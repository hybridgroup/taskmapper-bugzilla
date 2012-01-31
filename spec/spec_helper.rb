$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'ticketmaster'
require 'ticketmaster-bugzilla'
require 'rspec'
require 'vcr'
require 'vcr_setup'

RSpec.configure do |config|
  
end

