# <a href="https://github.com/dmarcoux/ruby_templates">dmarcoux/ruby_templates</a>

Templates for common files/configs I use in Ruby projects.

### Rubocop

Configured with `.rubocop.yml` and to be imported into other projects as
explained in the file itself.

### setup_example_files.sh

Quickly setup example files under `config/` by running `./setup_example_files.sh`

### Docker and Docker Compose

Minimal setup for a *Rails* application with the following features:
- Caching installation of gems within a *Docker* volume
- *PostgreSQL* database

**Usage**

Each *Docker* container has usage examples in
[docker-compose.yml](docker-compose.yml).

### TODO

- Add skeleton *Rails* app
- Add more services in *Docker Compose* setup (redis, etc...)
- Scale *Docker Compose* setup (use `scale` for `rails` service)
