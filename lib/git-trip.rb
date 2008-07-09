$LOAD_PATH.unshift File.dirname(__FILE__)

# Third-party libraries...
require 'rubygems'
require 'digest/sha1'
require 'grit'
require 'json'
require 'open-uri'
require 'RMagick'

# GitTrip libraries.
require 'core_ext/hash'
require 'git-trip/errors'
require 'git-trip/gitter'
require 'git-trip/paint_mode'
require 'git-trip/painter'

module GitTrip
  VERSION = '0.0.4'
  include GitTrip::Errors
end
