# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{richfile}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Till Salzer"]
  s.date = %q{2009-04-02}
  s.description = %q{Extends Ruby File objects with some rich instance attributes.}
  s.email = %q{till.salzer@googlemail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/richfile", "lib/richfile/base.rb", "lib/richfile/digests.rb", "lib/richfile/mimetype.rb", "lib/richfile.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tsalzer/richfile}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{More attributes for Ruby File}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
