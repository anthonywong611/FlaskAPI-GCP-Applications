import os
import sqlalchemy


# connect_tcp_socket initializes a TCP connection pool
# for a Cloud SQL instance of Postgres.
def connect_tcp_socket() -> sqlalchemy.engine.base.Engine:

    db_host = os.environ["INSTANCE_HOST"]  # e.g. '127.0.0.1' ('172.17.0.1' if deployed to GAE Flex)
    db_user = os.environ["DB_USER"]  # e.g. 'my-db-user'
    db_pass = os.environ["DB_PASS"]  # e.g. 'my-db-password'
    db_name = os.environ["DB_NAME"]  # e.g. 'my-database'
    db_port = os.environ["DB_PORT"]  # e.g. 5432

    connect_args = {}

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
