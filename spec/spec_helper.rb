require "rspec"
require 'capybara/rspec'

# require_relative "../lib/team_data"
# require_relative "../models/player"
# require_relative "../models/team"

require_relative '../server.rb'

Capybara.app = Sinatra::Application
