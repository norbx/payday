require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'yaml'
require 'active_record'

require_relative './../lib/fill_transaction_dates'
require_relative './../lib/get_monthly_report'
require_relative './../lib/read_csv'

Bundler.require

# Initialize Postgresql
db_yml = YAML.safe_load(File.open('./config/database.yml'))
puts db_yml

ActiveRecord::Base.establish_connection(db_yml)
