# Use the official lightweight Python image.
# https://hub.docker.com/_/python
FROM python:3.8-slim

COPY requirements.txt ./

# Install production dependencies.
RUN virtualenv --python python3 env && \
     source env/bin/activate && \
     pip3 install -r requirements.txt

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Run the web service on container startup. Here we use the gunicorn
# webserver, with one worker process and 8 threads.
# For environments with multiple CPU cores, increase the number of workers
# to be equal to the cores available.
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app