# -*- encoding: utf-8 -*-
# stub: rails-assets-card 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-assets-card"
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["rails-assets.org"]
  s.date = "2017-08-21"
  s.description = "Card let's you add an interactive, CSS3 credit card animation to your credit card form to help your users through the process."
  s.homepage = "https://github.com/jessepollak/card"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "Card let's you add an interactive, CSS3 credit card animation to your credit card form to help your users through the process."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails-assets-jquery>, [">= 1.5"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rails-assets-jquery>, [">= 1.5"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails-assets-jquery>, [">= 1.5"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
