require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler'

Bundler.require :default

require 'strscan'
require 'string_stubber/base'
require 'string_stubber/core_ext'

module StringStubber
  extend StringStubber::Base
end

class String
  include StringStubber::CoreExt
end
