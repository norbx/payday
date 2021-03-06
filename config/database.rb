require 'erb'
require 'yaml'
require 'active_record'

db_yml = YAML.safe_load(ERB.new(File.read('./config/database.yml')).result)

ActiveRecord::Base.establish_connection(db_yml)
