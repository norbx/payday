require 'rubygems'
require 'bundler/setup'
require 'csv'

Dir['/../lib/*'].each { |file| require file } 

Bundler.require
