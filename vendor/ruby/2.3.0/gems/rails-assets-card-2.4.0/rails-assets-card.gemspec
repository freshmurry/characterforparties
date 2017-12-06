# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails-assets-card/version'

Gem::Specification.new do |spec|
  spec.name          = "rails-assets-card"
  spec.version       = RailsAssetsCard::VERSION
  spec.authors       = ["rails-assets.org"]
  spec.description   = "Card let's you add an interactive, CSS3 credit card animation to your credit card form to help your users through the process."
  spec.summary       = "Card let's you add an interactive, CSS3 credit card animation to your credit card form to help your users through the process."
  spec.homepage      = "https://github.com/jessepollak/card"
  spec.license       = "MIT"

  spec.files         = `find ./* -type f | cut -b 3-`.split($/)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-assets-jquery", ">= 1.5"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
