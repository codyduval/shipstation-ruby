require 'rake/testtask'
require "bundler/gem_tasks"

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -I extra -r shipstation_ruby.rb"
end
 
Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/shipstation_ruby/*_spec.rb']
  t.verbose = true
end
 
task :default => :test