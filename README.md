# 01_01 TeamCity
[TeamCity Professional](https://www.jetbrains.com/teamcity/) is a self-hosted, build management and continuous integration server from JetBrains, the company behind popular software development tools and the Kotlin programming language.

## Prequisites
1. A [GitHub account](https://github.com/join) is required to host the code for the sample application.
1. An [Amazon Web Services account](https://aws.amazon.com/free) is needed to deploy and host the Jenkins server and the sample application used for the deployment target.
1. The sample application should be in place before starting.  See [00_06 About the Exercise Files](../../ch0_introduction/00_06_about_the_exercise_files/README.md) for steps to deploy the sample application.

## Implement the Experimental Pipeline
### 1. Create a GitHub repo for the sample application code
1. Create a new GitHub repo.
1. From ther repo home page, select **Add file -> Upload files**.
1. Select **choose your files** and browse to the exercise files for this lesson on your local system.
1. Select all of the files and then select **Open**.
1. After the files have been uploaded, enter a commit message and select **Commit changes**.

### 2. Deploy the TeamCity server
1. Log into your AWS account.  Select the search bar at the top of the page and enter **CloudFormation**.
1. On the CloudFormation homepage, select **Create stack**.  If the button includes a dropdown, select **With new resources (standard)**.
1. Under "Prerequisite - Prepare template", confirm that "Template is ready" is selected.
1. Under "Specify template", select **Upload a template file**.  Select **Chose file**.  Browse to the exercise files for this lesson on your local system.  Select [`teamcity-cloudformation-template.yml`](./teamcity-cloudformation-template.yml).  Select **Open**. Select **Next**.
1. Enter a name for the stack under "Stack name"; `teamcity` is a good choice. *Note that the name should only include letters (A-Z and a-z), numbers (0-9), and dashes (-)*.  
1. Accept the defaults under "Parameters" and select **Next**.
1. On the "Configure stack options" screen, keep all options as the default.  Scroll to the bottom of the page and select **Next**.
1.  On the "Review" screen, scroll to the bottom of the page and select the **checkbox** next to "I acknowledge that AWS CloudFormation might create IAM resources with custom names".  Select **Submit**.
1. Review the "Events" tab on the stack homepage until *CREATE_COMPLETE* is reported under the "Status" column for the Logical ID that matches your stack name. *Note that it may take 5 to 10 minutes for the stack to report CREATE_COMPLETE*.
1.  On the stack homepage, select the "Outputs" column.  Open the value for the key "URL" in a new tab.

### 3. Configure the TeamCity server
1. On the TeamCity homepage, select **Proceed**.
2. On the "Database connection setup" page, next to "Select the database type", select **Internal (HSQLDB)**.  *Note that this option selects an embedded database which is for evaluation purposes and is not intended for production use*.  Select **Proceed**.
3. On the "License Agreement" page, scroll to the bottom of the page, select the checkbox next to **Accept license agreement**.  Select **Continue**.
4. On the "Create Administrator Account" page, select a username and password for your admin account and select **Create Account**.

TODO: Increase the size of the disk for the server.
TODO: Add an agent to the cloudformation template.
TODO: Update the other cloudformation templates to increase the size of the default volume.
TODO: Install the tools (zip, python, aws cli) on the agent.
TODO: Connect the agent in the server configuration.

### 4. Create the pipeline
### 5. Run the pipeline