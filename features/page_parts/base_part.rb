require 'watir-page-helper'

class BasePart
  include WatirPageHelper

  attr_reader :key

  def initialize(browser, key)
    @key = key
    @browser = part_root(browser, key)
  end

  def part_root(browser, key)
    raise 'this method should be overridden and return the HTML element that holds the page part using the key to find it'
  end

end