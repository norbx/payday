require 'erb'
require 'yaml'

ENV['ENVIRONMENT'] = 'production' if production_branch?

db_yml = YAML.safe_load(ERB.new(File.read('./config/database.yml')).result)

ActiveRecord::Base.establish_connection(db_yml)
