require 'rubygems'
require 'rspec'
require 'net/http'
require File.dirname(__FILE__) + '/environment/browser_picker'
require File.dirname(__FILE__) + '/environment/region_picker'
require File.dirname(__FILE__) + '/matchers/return_a'

browser_picker = BrowserPicker.new

if browser_picker.headless?
  WEBDRIVER = false
else
  WEBDRIVER = true
end

BROWSER = browser_picker.browser_obj
BROWSER_TYPE = browser_picker.browser_type

region_picker = RegionPicker.new

REGION_BASE_URL = region_picker.get_region_url(ENV['TEST_SERVER'])

puts "the pid of this cucumber run: #{Process.pid}."

class String
  def newline_helper
    self.gsub(/[\r\n]/, ' ').gsub(/ +/, ' ')
  end

  def ssn_format
    self.gsub(/^(\d\d\d)(?=[^-])(\d\d)(?=[^-])/, '\1-\2-')
  end
end

class Fixnum
  def ssn_format
    self.to_s.ssn_format
  end
end

def image_src_uri_builder(image_uri)
  image_uri = "#{REGION_BASE_URL}#{image_uri}" unless image_uri =~ /#{REGION_BASE_URL}/
  image_uri
end