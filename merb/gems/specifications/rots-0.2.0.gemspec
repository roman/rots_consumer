# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rots}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Roman Gonzalez"]
  s.date = %q{2009-03-23}
  s.default_executable = %q{rots}
  s.description = %q{Ruby OpenID Test Server (ROST) provides a basic OpenID server made in top of the Rack gem. With this small server, you can make dummy OpenID request for testing purposes, the success of the response will depend on a parameter given on the url of the authentication request.}
  s.email = %q{romanandreg@gmail.com}
  s.executables = ["rots"]
  s.extra_rdoc_files = ["README"]
  s.files = [".gitignore", "AUTHORS", "README", "Rakefile", "bin/rots", "lib/rots.rb", "lib/rots/identity_page_app.rb", "lib/rots/server_app.rb", "lib/rots/test_helper.rb", "rots.gemspec", "spec/server_app_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/roman}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rots}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{an OpenID server for making tests of OpenID clients implementations}
  s.test_files = ["spec/server_app_spec.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<ruby-openid>, ["~> 2.0.0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<ruby-openid>, ["~> 2.0.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<ruby-openid>, ["~> 2.0.0"])
  end
end
