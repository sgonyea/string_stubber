require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler'

Bundler.require :default

require 'strscan'
require 'stubber/base'
require 'stubber/core_ext'

module Stubber
  extend Stubber::Base
end

class String
  include Stubber::CoreExt
end
