$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems' if RUBY_VERSION < '1.9'
require 'bundler'

Bundler.require

require 'strscan'

require 'string_stubber/base'
require 'string_stubber/core_ext'

module StringStubber
  extend StringStubber::Base
end
