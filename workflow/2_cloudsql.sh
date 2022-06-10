# Create a small Cloud SQL Postgres instance
gcloud sql instances create $INSTANCE_NAME \
--database-version=POSTGRES_14 \
--tier=db-g1-small \
--region=$REGION \
--root-password=$DB_PASS

# Create a database for the Flask API to store its data 
gcloud sql databases create $DB_NAME \
--instance=$INSTANCE_NAME  

# Create a new user to administer the database
gcloud sql users create $DB_USER \
--instance=$INSTANCE_NAME \
--password=$DB_PASS  

# Connect the the database via TCP connection:
# psql -U $DB_USER --host=$INSTANCE_HOST


