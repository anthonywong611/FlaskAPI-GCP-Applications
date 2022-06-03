import os
import ssl

import sqlalchemy


# connect_tcp_socket initializes a TCP connection pool
# for a Cloud SQL instance of Postgres.
def connect_tcp_socket() -> sqlalchemy.engine.base.Engine:
    # Note: Saving credentials in environment variables is convenient, but not
    # secure - consider a more secure solution such as
    # Cloud Secret Manager (https://cloud.google.com/secret-manager) to help
    # keep secrets safe.
    db_host = os.environ["INSTANCE_HOST"]  # e.g. '127.0.0.1' ('172.17.0.1' if deployed to GAE Flex)
    db_user = os.environ["DB_USER"]  # e.g. 'my-db-user'
    db_pass = os.environ["DB_PASS"]  # e.g. 'my-db-password'
    db_name = os.environ["DB_NAME"]  # e.g. 'my-database'
    db_port = os.environ["DB_PORT"]  # e.g. 5432

    connect_args = {}
    # [END cloud_sql_postgres_sqlalchemy_connect_tcp]
    # For deployments that connect directly to a Cloud SQL instance without
    # using the Cloud SQL Proxy, configuring SSL certificates will ensure the
    # connection is encrypted.
    if os.environ.get("DB_ROOT_CERT"):
        db_root_cert = os.environ["DB_ROOT_CERT"]  # e.g. '/path/to/my/server-ca.pem'
        db_cert = os.environ["DB_CERT"]  # e.g. '/path/to/my/client-cert.pem'
        db_key = os.environ["DB_KEY"]  # e.g. '/path/to/my/client-key.pem'

        ssl_context = ssl.SSLContext()
        ssl_context.verify_mode = ssl.CERT_REQUIRED
        ssl_context.load_verify_locations(db_root_cert)
        ssl_context.load_cert_chain(db_cert, db_key)
        connect_args["ssl_context"] = ssl_context

    # [START cloud_sql_postgres_sqlalchemy_connect_tcp]
    pool = sqlalchemy.create_engine(
        # Equivalent URL:
        # postgresql+pg8000://<db_user>:<db_pass>@<db_host>:<db_port>/<db_name>
        sqlalchemy.engine.url.URL.create(
            drivername="postgresql+pg8000",
            username=db_user,
            password=db_pass,
            host=db_host,
            port=db_port,
            database=db_name,
        ),
        connect_args=connect_args,
        
        pool_size=5, # maximum number of permanent connections to keep.
        # Temporarily exceeds the set pool_size if no connections are available.
        max_overflow=2,
        # The total number of concurrent connections for your application will be
        # a total of pool_size and max_overflow.

        # maximum number of seconds to wait when retrieving a new connection from the pool. 
        pool_timeout=30,  # 30 seconds

        # maximum number of seconds a connection can persist.
        pool_recycle=1800,  # 30 minutes
    )
    return pool
