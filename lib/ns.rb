require 'version'
require 'time'
require 'httpi'
require 'nori'

this = Pathname.new(__FILE__).realpath
lib_path = File.expand_path("..", this)
$:.unshift(lib_path)

$ROOT = File.expand_path("../", lib_path)

Dir.glob(File.join(lib_path, '/**/*.rb')).each do |file|
  require file
end

module Ns
  class << self

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Ns::Configuration.new
    end

  end
end
