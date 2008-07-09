$LOAD_PATH.unshift File.dirname(__FILE__), File.dirname("#{__FILE__}/vendor")

# Third-party libraries...
require 'rubygems'
require 'digest/sha1'
require 'json'
require 'open-uri'
require 'RMagick'

# ...in ./vendor/
require File.join(File.dirname(__FILE__), '..', 'vendor/grit/lib/grit')

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
