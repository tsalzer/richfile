# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{richfile}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Till Salzer"]
  s.date = %q{2009-03-25}
  s.description = %q{Extends File objects with some rich instance attributes.}
  s.email = %q{till.salzer@googlemail.com}
  s.extra_rdoc_files = ["lib/richfile/base.rb", "lib/richfile.rb", "MIT-LICENSE", "README.rdoc", "tasks/richfile_tasks.rake"]
  s.files = ["init.rb", "install.rb", "lib/richfile/base.rb", "lib/richfile.rb", "MIT-LICENSE", "Rakefile", "README.rdoc", "specs/richfile_spec.rb", "specs/SimpleDigestTest.txt", "tasks/richfile_tasks.rake", "uninstall.rb", "Manifest", "richfile.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tsalzer/richfile}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Richfile", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{richfile}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Extends File objects with some rich instance attributes.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end
