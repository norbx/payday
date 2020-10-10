task :payday do
  ruby './payday.rb'
end

task :c do
  sh "irb -r ./config/application"
end

namespace :db do
  task :create do
    ruby './db/schema.rb'
  end
end
