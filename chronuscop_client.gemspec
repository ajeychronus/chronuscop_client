# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{chronuscop_client}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ajey"]
  s.date = %q{2011-06-30}
  s.description = %q{This gem helps you to easily tweak your rails app to use the chronuscop server.}
  s.email = %q{ajey@chronus.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "chronuscop_client.gemspec",
    "lib/chronuscop_client.rb",
    "lib/chronuscop_client/configuration.rb",
    "lib/chronuscop_client/railtie.rb",
    "lib/chronuscop_client/synchronizer.rb",
    "lib/tasks/chronuscop_client_tasks.rake",
    "test/helper.rb",
    "test/test_chronuscop_client.rb"
  ]
  s.homepage = %q{http://github.com/ajey/chronuscop_client}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{chronuscop_client gem to easily integrate your rails app with the chronuscop server.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, ["= 1.0.0"])
      s.add_runtime_dependency(%q<xml-simple>, ["= 1.0.15"])
      s.add_runtime_dependency(%q<redis>, ["= 2.2.1"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<mechanize>, ["= 1.0.0"])
      s.add_dependency(%q<xml-simple>, ["= 1.0.15"])
      s.add_dependency(%q<redis>, ["= 2.2.1"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<mechanize>, ["= 1.0.0"])
    s.add_dependency(%q<xml-simple>, ["= 1.0.15"])
    s.add_dependency(%q<redis>, ["= 2.2.1"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

