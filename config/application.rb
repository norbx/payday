require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'dotenv/load'
require 'active_record'
require 'byebug'

Dir['./lib/**/*.rb'].sort.each { |file| require file }

Bundler.require
