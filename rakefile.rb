task :payday do
  ruby './payday.rb'
end

namespace :db do
  task :create do
    ruby './db/schema.rb'
  end
end
