require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'dotenv/load'
require 'active_record'
require 'tty-prompt'
require 'gnuplot'

Dir['./lib/models/*.rb'].each { |file| require file }
Dir['./lib/plots/*.rb'].each { |file| require file }
Dir['./lib/*.rb'].each { |file| require file }

require './helpers/application_helper'

Bundler.require

include ApplicationHelper # rubocop:disable Style/MixinUsage
