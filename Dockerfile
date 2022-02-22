# https://hub.docker.com/_/ruby
FROM ruby:3.1.1
MAINTAINER Dany Marcoux

# Enforce C.UTF-8 encoding, otherwise it is inherited from the host machine
ENV LANG C.UTF-8

# Update package index files
RUN apt-get update -qq

# Install dependencies for the application
RUN apt-get install -qq -y build-essential
# CHANGEME: According to your application's dependencies, add the packages you need to the `apt-get install (...)` line above
# postgres (required): libpq-dev
# sqlite (required): sqlite3 libsqlite3-dev
# redis (optional - nice to have for connecting directly to redis when debugging, it provides redis-cli): redis-tools

# Set the directory of the application and switch to it
ENV WORK_DIR /web_app
RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

ARG USER_ID=1000
# Create a user with the same ID as the user building this Dockerfile
RUN useradd --gid users --uid $USER_ID --home-dir /home/web_app_user --create-home web_app_user
# Add the user to the sudoers
RUN echo 'web_app_user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
# Set the user as the owner of the working directory
RUN chown -R web_app_user $WORK_DIR

# Speed up bundle install
ENV BUNDLE_JOBS 4

# Path where gems will be installed. It can be cached with volumes
ENV BUNDLE_PATH /gems
RUN mkdir -p $BUNDLE_PATH
# Make $BUNDLE_PATH writable to the user
RUN chown -R web_app_user $BUNDLE_PATH

# As the web_app_user in the users group, copy all files from the project into the container
COPY --chown=web_app_user:users . $WORK_DIR

# Default value for the port of the Rails server, which can be overriden on build (with ARG) or at anytime (by setting the ENV variable)
ARG port=3000
ENV RAILS_PORT $port

# Everything after the following line will be executed as the new user
USER web_app_user

# Check if gems are installed, if not install them, then remove any stale PID before starting the Rails server
CMD (bundle check || bundle install) && rm $WORK_DIR/tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0 -p $RAILS_PORT
