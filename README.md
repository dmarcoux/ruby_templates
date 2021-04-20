# <a href="https://github.com/dmarcoux/ruby_templates">dmarcoux/ruby_templates</a>

Templates for common files/configs I use in Ruby projects.

## How to Use This Template

1. Create a new repository based on this repository:
- Go to this [repository's page](https://github.com/dmarcoux/ruby_templates),
  click on the `Use this template` button and follow instructions.

*OR*

- With [GitHub's CLI](https://github.com/cli/cli), run `gh repo create
  NEW_REPOSITORY_NAME --template=dmarcoux/ruby_templates`.

2. Search for `CHANGEME` in the newly created repository to adapt it to your
   needs.

3. Remove `Gemfile.lock` since it's only in this repository to be able to test
   the GitHub Actions configuration.

## setup_example_files.sh

Quickly setup example files under `config/` by running `./setup_example_files.sh`

## [Dependabot](https://dependabot.com/)

Automated dependency updates. Details in the [config](./.github/dependabot.yml).

## [GitHub Actions](https://docs.github.com/en/actions)

Linters, specs and more. Details in the files under [.github/workflows](./.github/workflows).

## Docker and Docker Compose

Minimal setup for a *Rails* application with the following features:
- Caching installation of gems within a *Docker* volume
- *PostgreSQL* database
- *Redis* in-memory database
- Keep command history for Bash, IRB and Pry (files created by a [rake task](./lib/tasks/development.rake))

### Usage

- Start the web application which is available at http://localhost:3000: `docker-compose up web_app`
- Start shell inside the web application container: `docker-compose run --rm --service-ports web_app bash`
- To generate a Rails project from scratch inside the container:
    ```bash
    # Install rails to be able to run `rails new`
    gem install rails
    # Generate Rails project as usual...
    rails new my_app
    ```
- Run specific specs: `docker-compose run web_app bash -c 'bundle exec rspec spec/models/user_spec.rb:12'`
- Create and migrate the database for development and only load the schema for test: `docker-compose run web_app bash -c 'bundle exec rake db:create db:migrate && RAILS_ENV=test bundle exec rake db:test:load'`
