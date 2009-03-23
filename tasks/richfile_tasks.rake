require 'rake'
require 'spec/rake/spectask'

ALWAYS_EXCLUDES=['specs/command_spec.rb']
EXCLUDES=['specsserver_spec.rb'].concat(ALWAYS_EXCLUDES)

def filelist(*opts)
  exclude = []
  o = *opts
  if o
    exclude = o[:exclude] if o[:exclude]
  end
  files = FileList['specs/**/*_spec.rb']
  exclude.each do |f|
    files.delete(f)
  end
  files
end

desc "Run all the specs"
Spec::Rake::SpecTask.new('specs') do |t|
  t.pattern = nil
  t.spec_files = filelist(:exclude => EXCLUDES)
  t.rcov = false
end

desc "Run all specs with RCov"
Spec::Rake::SpecTask.new('rcov') do |t|
  t.spec_files = filelist(:exclude => EXCLUDES)
  t.rcov = true
  t.rcov_opts = ['--exclude', 'specs/.*,buildlib/project\.rb,buildlib/buildlib\.rb,buildlib/command\.rb']
end

task :default => [:specs]
