class BrowserPicker

  def initialize
    @headless = true
    @headless = false if ENV['BROWSER'] =~ /true/i
  end

  def headless?
    @headless
  end

  def webdriver?
    return false if (headless? && RUBY_PLATFORM =~ /java/)
    return true
  end

  def browser_obj
    unless webdriver?
      require 'celerity'
      browser = Celerity::Browser
      Celerity.index_offset = 0
      puts "Running Headless"
    else
      require "watir-webdriver"
      browser = Watir::Browser
      puts "Running with WebDriver"
    end
    browser
  end

  def browser_type
    if webdriver?
      if ENV['CHROME']
        puts "Using Chrome"
        return :chrome
      elsif ENV['IE']
        puts "Using IE"
        return :ie
      elsif ENV['HTMLUNIT']
        return WebDriver::Remote::Capabilities.htmlunit(:javascript_enabled => true)
      else #ENV['FIREFOX']
        puts "Using Firefox"
        if ENV['FIREFOXPATH']
          Selenium::WebDriver::Firefox.path = ENV['FIREFOXPATH']
          puts "at #{ENV['FIREFOXPATH']}"
        end
        return :firefox
      end
    else
      puts "Using Celerity (HtmlUnit)"
    end

  end


end
