# frozen_string_literal: true

require "English" # for $CHILD_STATUS

# From upstream https://github.com/thoughtbot/factory_bot/blob/b6606abe7aceef0c6f57e2d4456a376d02fb16a8/GETTING_STARTED.md#linting-factories
namespace :factorybot do
  desc "Verify that all FactoryBot factories are valid"
  task lint: :environment do |task|
    if Rails.env.test?
      conn = ActiveRecord::Base.connection
      conn.transaction do
        FactoryBot.lint traits: true, verbose: true
        raise ActiveRecord::Rollback
      end
    else
      system("bundle exec rake #{task.name} RAILS_ENV='test'")
      raise if $CHILD_STATUS.exitstatus.nonzero?
    end
  end
end
