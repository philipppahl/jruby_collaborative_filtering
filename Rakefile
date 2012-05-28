require 'fileutils'
require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Run all the tests"
task :default => [:test]
task :test => ['test:units']

# rake test:pig can be called separately

namespace :test do   
  
  ENV['RACK_ENV'] = 'test'
  
  [ :units ].each do |category|
    Rake::TestTask.new(category) do |t|
      t.libs << "test"
      t.test_files = Dir["test/#{category}/**/*_test.rb"]
      t.verbose = true
    end
  end
  
  
end