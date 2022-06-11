# FlaskAPI on Google Cloud Platform (GCP)
- **Goal**: Deploy a containerized Flask API on Google Cloud Platform, exposing it the internet for API users to make requests and store user information. 


## Application Overview


## Infrastructure Overview
![](images/architecture.png)


---
## Running the Project
**1. Go to the Goole Cloud console**
- Create a new project
- Keep note of the Project ID
- [Determine and keep note of the region and zone](https://cloud.google.com/compute/docs/regions-zones#available)

```bash
gcloud compute zones list  # Run this command for reference
```

**2. Activate Cloud Shell on the top right header and clone this repository in the home directory**

```bash
git clone https://github.com/anthonywong611/paas-on-gcp.git
```

**3. Open the Cloud Shell Editor and set up environment variables**
- Go to the workflow folder and open [0_var.sh](https://github.com/anthonywong611/paas-on-gcp/blob/main/workflow/0_var.sh)
- Update the project variables with your Project ID, Region, and Zone
- Update the database instance variables to your preference

```bash
# --- Project Info --- #
export PROJECT_ID='<project-id>'  # TODO: Replace these values
export REGION='<region>'  # TODO: Replace these values 
export ZONE='<zone>'  # TODO: Replace these values
export WORKING_DIR=$(pwd)

# --- Database Instance Info --- #
export INSTANCE_HOST='127.0.0.1'
export INSTANCE_NAME='<instance-name>'  # TODO: Replace these values
export DB_USER='<user-name>'  # TODO: Replace these values
export DB_PASS='<password>'  # TODO: Replace these values
export DB_NAME='<database-name>'  # TODO: Replace these values
export DB_PORT='5432'
```

**4. Open the Terminal and execute the infrastructure workflow**

```bash
cd paas-on-gcp/  # if not in the directory already
```

- The [main.sh] file will run all files in the workflow directory

```bash
source main.sh
```

- Wait until all resources have been provisioned



- Open the [deployment.yaml](https://github.com/anthonywong611/paas-on-gcp/blob/main/deployment.yaml) file
- Update, where a "TODO: Replace these values" comment indicates, the lines with the corresponding variables

<!-- ## 1. Create an application repository on GitHub. Document configuration and deployment steps in a README document.
---
## 2. Using the application repository, create a simple container app (using Docker) using Flask or any other simple API framework to expose GET and POST methods.  
- The app should create the table in the database if it does not exist (for all verbs). 
- The POST method is used to insert a new record into the table and the GET method returns records in the table.  
- Use JSON for the request and response formats. 
---
## 3. Create a GitHub action to deploy the application when a PR is merged into the develop branch.
---
### Challenge 1: Deploy the GKE cluster and database instance on a private VPC network, with access via a Global HTTPS load balancer. 
---
### Challenge 2: Implement a basic service mesh using Istio including an egress service entry for Cloud SQL.
--- -->
