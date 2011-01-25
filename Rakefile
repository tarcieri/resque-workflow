require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "resque-workflow"
  gem.summary = "A DSL for describing workflows whose steps are Resque jobs"
  gem.description = "resque-workflow allows you to build multi-step job workflows out of any ActiveRecord model"
  gem.email = "tony@medioh.com"
  gem.homepage = "http://github.com/tarcieri/resque-workflow"
  gem.authors = ["Tony Arcieri"]
  
  gem.add_dependency 'activerecord', '~> 3.0.0'
  gem.add_dependency 'resque',       '~> 1.10.0'
  gem.add_dependency 'resque-retry', '~> 0.1.0'
  
  gem.add_development_dependency 'rspec', '>= 2.0.0'
  gem.add_development_dependency 'sqlite3'
  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:rspec)
task :spec => :rspec

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :default => :rspec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "resque-workflow #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Dir['tasks/**/*.rake'].each { |task| load task }