# frozen_string_literal: true

namespace :development do
  desc "Setup the develoment environment"
  task setup: :environment do
    bash_history = Rails.root.join("docker-files/home/.bash_history")
    File.new(bash_history, "w+") unless File.exist?(bash_history)
    irb_history = Rails.root.join("docker-files/home/.irb_history")
    File.new(irb_history, "w+") unless File.exist?(irb_history)
    pry_history = Rails.root.join("docker-files/home/.pry_history")
    File.new(pry_history, "w+") unless File.exist?(pry_history)
  end
end
