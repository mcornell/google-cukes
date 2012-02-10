require 'rubygems'
require 'rspec'
require 'net/http'
require File.dirname(__FILE__) + '/environment/browser_picker'
require File.dirname(__FILE__) + '/environment/selenium_server'
require File.dirname(__FILE__) + '/matchers/return_a'

browser_picker = BrowserPicker.new

if browser_picker.headless?
  HEADLESS = true
else
  HEADLESS = false
end

BROWSER = browser_picker.browser_obj
BROWSER_TYPE = browser_picker.browser_type

puts "the pid of this cucumber run: #{Process.pid}."
