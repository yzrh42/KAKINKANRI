# -*- encoding: utf-8 -*-
# stub: omniauth-line 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-line".freeze
  s.version = "0.1.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["kazasiki".freeze]
  s.date = "2021-02-11"
  s.description = "OmniAuth strategy for Line".freeze
  s.email = ["kazasiki@gmail.com".freeze]
  s.homepage = "https://github.com/kazasiki/omniauth-line".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.5.3".freeze
  s.summary = "OmniAuth strategy for Line".freeze

  s.installed_by_version = "3.5.3".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<json>.freeze, [">= 2.3.0".freeze])
  s.add_runtime_dependency(%q<omniauth-oauth2>.freeze, ["~> 1.3".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0".freeze])
end
