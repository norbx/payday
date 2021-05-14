require 'rubygems'
require 'bundler/setup'
require 'csv'
require 'dotenv/load'
require 'active_record'
require 'tty-prompt'

Dir['./lib/*.rb'].sort.each { |file| require file }
Dir['./lib/models/*.rb'].sort.each { |file| require file }

require './helpers/application_helper'

Bundler.require

include ApplicationHelper # rubocop:disable Style/MixinUsage
