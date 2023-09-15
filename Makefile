FUNCTION=
PLATFORM=
ENVIRONMENT=
URL=

CODE=$(shell ls *.py)

hello99:
	@echo "Here are the targets for this Makefile:"
	@echo "  requirements  - install the project requirements"
	@echo "  lint          - run linters on the code"
	@echo "  black         - run black to format the code"
	@echo "  test          - run the tests"
	@echo "  build         - build the lambda.zip file"
	@echo "  deploy        - deploy the lambda.zip file to AWS"
	@echo "  clean         - remove the lambda.zip file"
	@echo "  all           - clean, lint, black, test, build, and deploy"
	@echo
	@echo
	@echo "You must set the PROFILE and FUNCTION variables to use the"
	@echo "deploy target.  For example:"
	@echo
	@echo "  make PROFILE=foo FUNCTION=bar deploy"
	@echo
	@echo "  PROFILE  - the AWS profile to use for the deployment."
	@echo "  FUNCTION - the name of the existing lambda function to update."

requirements:
	pip install -U pip
	pip install --requirement requirements.txt

check:
	set
	zip --version
	python --version
	pylint --version
	flake8 --version
	aws --version
	
lint:
	pylint --exit-zero --disable=R,C $(CODE)
	flake8 --exit-zero $(CODE)

black:
	black --diff $(CODE)

test:
	python -m unittest -v index_test

build:
	zip lambda.zip index.py data.json

deploy:
	aws sts get-caller-identity
	
	aws lambda wait function-active \
		--function-name="$(FUNCTION)"
	
	aws lambda update-function-configuration \
		--function-name="$(FUNCTION)" \
		--environment "Variables={PLATFORM=$(PLATFORM),ENVIRONMENT=$(ENVIRONMENT)}"

	aws lambda wait function-updated \
		--function-name="$(FUNCTION)"
	
	aws lambda update-function-code \
		--function-name="$(FUNCTION)" \
	 	--zip-file=fileb://lambda.zip
	    
	aws lambda wait function-updated \
		--function-name="$(FUNCTION)"

testdeployment:
	curl -s $(URL) | grep "<h1>The Sample Application</h1>"

clean:
	rm -vf lambda.zip

all: clean lint black test build deploy

.PHONY: test build deploy all clean

