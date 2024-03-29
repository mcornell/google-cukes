require 'watir-page-helper'

class BasePage
  include WatirPageHelper

  def initialize(browser, visit=false)
    @browser = browser

    goto if visit

    wait_until_page_ready
  end

  def wait_until_page_ready
    if @browser.exist? && @browser.url =~ /^http/
      if BROWSER_TYPE
        @browser.body.wait_until_present
      else
        @browser.wait_until { @browser.html.length > 0 } # Apparently there's no body object in celerity.
      end
    end
  end

end