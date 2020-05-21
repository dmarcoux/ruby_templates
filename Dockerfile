FROM ruby:2.7.1
MAINTAINER Dany Marcoux

# Enforce C.UTF-8 encoding, otherwise it is inherited from the host machine
ENV LANG C.UTF-8

# Update package index files
RUN apt-get update -qq

# Install dependencies for the application
RUN apt-get install -qq -y build-essential
# TODO: Select one database
# postgres: libpq-dev
# sqlite: sqlite3 libsqlite3-dev

# Set the directory of the application and switch to it
ENV WORK_DIR /app
RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

# Speed up bundle install
ENV BUNDLE_JOBS 4

# Path where gems will be installed. It can be cached with volumes
ENV BUNDLE_PATH /gems

# Copy all files from the project into the container
COPY . $WORK_DIR

# Default value for the port of the Rails server, which can be overriden on build (with ARG) or at anytime (by setting the ENV variable)
ARG port=80
ENV RAILS_PORT $port

# Check if gems are installed, if not install them, then start the Rails server
CMD (bundle check || bundle install) && bundle exec rails s -b 0.0.0.0 -p $RAILS_PORT
