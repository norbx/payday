require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'yaml'
require 'active_record'

require './lib/src/fill_transaction_dates'
require './lib/src/get_monthly_report'
require './lib/src/read_csv'

Bundler.require

# Initialize Postgresql
db_yml = YAML.safe_load(File.open('./config/database.yml'))

ActiveRecord::Base.establish_connection(db_yml)
