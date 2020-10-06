require './config/application'

namespace :db do
  task :create do
    ActiveRecord::Migration.class_eval do
      create_table :expenses do |t|
        t.string :month
        t.decimal :amount, precision: 8, scale: 2, default: 0.0
      end
    end
  end
end
