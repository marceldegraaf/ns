# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ns/version'

Gem::Specification.new do |gem|
  gem.name          = "ns-api"
  gem.version       = '0.3'
  gem.authors       = ["Marcel de Graaf"]
  gem.email         = ["mail@marceldegraaf.net"]
  gem.description   = %q{A Ruby implementation of the NS (Dutch Railways) API}
  gem.summary       = %q{A Ruby implementation of the NS (Dutch Railways) API}
  gem.homepage      = "https://github.com/marceldegraaf/ns"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httpi'
  gem.add_dependency 'nori'
  gem.add_dependency 'nokogiri'
end
