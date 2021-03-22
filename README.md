# <a href="https://github.com/dmarcoux/ruby_templates">dmarcoux/ruby_templates</a>

Templates for common files/configs I use in Ruby projects.

### setup_example_files.sh

Quickly setup example files under `config/` by running `./setup_example_files.sh`

### Docker and Docker Compose

Minimal setup for a *Rails* application with the following features:
- Caching installation of gems within a *Docker* volume
- *PostgreSQL* database

#### Usage

- Start the web application which is available at localhost:3000: `docker-compose up web_app`
- Start shell inside the web application container: `docker-compose run --rm --service-ports web_app bash`
- Run specific specs: `docker-compose run web_app bash -c 'bundle exec rspec spec/models/user_spec.rb:12'`
- Create and migrate the database for development and only load the schema for test: `docker-compose run web_app bash -c 'bundle exec rake db:create db:migrate && RAILS_ENV=test bundle exec rake db:test:load'`
