# -*- encoding: utf-8 -*-
# stub: omniauth-stripe-connect 2.10.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-stripe-connect"
  s.version = "2.10.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Isaac Sanders"]
  s.date = "2017-02-01"
  s.description = "Stripe Connect OAuth2 Strategy for OmniAuth 1.0."
  s.email = ["isaac@isaacbfsanders.com"]
  s.homepage = "https://stripe.com/docs/connect"
  s.rubygems_version = "2.2.2"
  s.summary = "Supports the OAuth 2.0 server-side and client-side flows. Read the Stripe Connect docs for more details: https://stripe.com/docs/connect"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, ["~> 1.3"])
      s.add_runtime_dependency(%q<omniauth-oauth2>, ["~> 1.4"])
    else
      s.add_dependency(%q<omniauth>, ["~> 1.3"])
      s.add_dependency(%q<omniauth-oauth2>, ["~> 1.4"])
    end
  else
    s.add_dependency(%q<omniauth>, ["~> 1.3"])
    s.add_dependency(%q<omniauth-oauth2>, ["~> 1.4"])
  end
end
