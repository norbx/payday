require './config/application'
require './config/database'

task :payday do
  ruby './exe/payday.rb'
end

task :c do
  sh 'bundle exec irb -r ./config/application -r ./config/database'
end

namespace :db do
  task :create do
    load './db/schema.rb'
  end

  task :seed do
    load './db/seeds.rb'
  end

  task :setup do
    load './db/schema.rb'
    load './db/seeds.rb'
  end
end
