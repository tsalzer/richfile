# Rakefile for img_gravatar
require 'rubygems'
require 'rake'
task :default => [:specs]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "richfile"
    s.summary = "More attributes for Ruby File"
    s.email = "till.salzer@googlemail.com"
    s.homepage = "http://github.com/tsalzer/richfile"
    s.description = "Extends Ruby File objects with some rich instance attributes."
    s.authors = ["Till Salzer"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
