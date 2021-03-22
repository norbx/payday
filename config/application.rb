require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'dotenv/load'
require 'active_record'
require 'tty-prompt'

Dir['./lib/*.rb'].sort.each { |file| require file }
Dir['./lib/models/*.rb'].sort.each { |file| require file }
Dir['./lib/categories/**/*.rb'].sort.each { |file| require file }

Bundler.require
