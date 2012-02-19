require 'rubygems'
require 'rake/clean'
require 'bundler/setup'
require 'cucumber'
require 'cucumber/rake/task'

desc "Clean the reports"
task 'clean' => :cleanup

desc "determine what to clean"
task :cleanup do
  CLEAN.include("error_pages", "hudson_report", "screenshots", "cucumber.html", "coverage")
end

desc "run all features in a browser"
task :browser => 'features:browser'

desc "run all features headless"
task :headless => 'features:headless'

task :default => :headless

def setup_environment
  puts "Any setup goes here"
end

namespace :features do

  desc "Sets environment to run on, and additional settings for test execution"
  task :setupenv do
    setup_environment
  end

  desc "Am I running in a browser?"
  task :isbrowser do
    ENV['BROWSER'] ||= 'true'
  end

  Cucumber::Rake::Task.new({:browser => ['features:setupenv', 'features:isbrowser']}, 'Run Cucumber Features using a Browser') do |t|
    t.profile = ENV['HUDSON'] ? 'browser_hudson' : 'browser'
    t.fork = false
    t.cucumber_opts = []
    t.cucumber_opts << ["--tags", ENV['TAGS']] if ENV['TAGS']
    t.cucumber_opts << ["", ENV['FEATURES']] if ENV['FEATURES']
  end

  Cucumber::Rake::Task.new({:headless => 'features:setupenv'}, 'Run Cucumber Features using a Headless Browser') do |t|
    t.profile = ENV['HUDSON'] ? 'hudson' : 'default'
    t.fork = false
    t.cucumber_opts = []
    t.cucumber_opts << ["--tags", ENV['TAGS']] if ENV['TAGS']
    t.cucumber_opts << ["", ENV['FEATURES']] if ENV['FEATURES']
  end

end