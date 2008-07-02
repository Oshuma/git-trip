$LOAD_PATH.unshift File.dirname(__FILE__)

# Third-party libraries.
require 'rubygems'
require 'json'
require 'open-uri'

# GitTrip libraries.
require 'core_ext/hash'
require 'git_trip/errors'
require 'git_trip/gitter'

module GitTrip
  include GitTrip::Errors
  VERSION = '1.0.0'
end
