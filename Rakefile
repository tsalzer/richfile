# Rakefile for img_gravatar
require 'rubygems'
require 'rake'
task :default => [:specs]
require 'echoe'

Echoe.new('richfile', '0.0.2') do |p|
  p.description = "Extends File objects with some rich instance attributes."
  p.url = "http://github.com/tsalzer/richfile"
  p.author = "Till Salzer"
  p.email = "till.salzer@googlemail.com"
  p.ignore_pattern = ["tmp/*", "script/*", "rdoc/*", "pkg/*", "coverage/*", "*.tmproj"]
  p.development_dependencies = ['rspec','rcov']
  p.rdoc_pattern = /^(lib|bin|tasks|ext)|^README.rdoc|^CHANGELOG|^TODO|^MIT-LICENSE|^COPYING$/
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
