$LOAD_PATH.unshift File.dirname(__FILE__)

# Third-party libraries...
require 'rubygems'
require 'digest/sha1'
require 'json'
require 'open-uri'
require 'rmagick'

# ...in ./vendor/
require 'vendor/grit/lib/grit'

# GitTrip libraries.
require 'core_ext/hash'
require 'git_trip/errors'
require 'git_trip/gitter'
require 'git_trip/painter'

module GitTrip
  VERSION = '0.0.2'
  include GitTrip::Errors
end
