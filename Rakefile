# -*- encoding: utf-8 -*-

require 'rubygems'
require 'rake'
task :default => [:specs]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "richfile"
    gem.summary = "More attributes for Ruby File"
    gem.email = "till.salzer@googlemail.com"
    gem.homepage = "http://github.com/tsalzer/richfile"
    gem.description = "Extends Ruby File objects with some rich instance attributes."
    gem.authors = ["Till Salzer"]
    gem.add_dependency 'tsalzer-typesafe', '>= 0.0.2'
    gem.add_development_dependency 'rspec', '>= 1.2.8'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

#Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'specs'
  spec.spec_files = FileList['specs/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'specs'
  spec.pattern = 'specs/**/*_spec.rb'
  spec.rcov = true
end

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "richfile #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
