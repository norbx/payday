require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'erb'
require 'yaml'
require 'active_record'
require 'dotenv/load'

Dir['./lib/**/*.rb'].sort.each { |file| require file }

Bundler.require

# Initialize Postgresql
db_yml = YAML.safe_load(ERB.new(File.read('./config/database.yml')).result)

ActiveRecord::Base.establish_connection(db_yml)
