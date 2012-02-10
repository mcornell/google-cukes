class BrowserPicker

  def initialize
    @headless = true
    @headless = false if ENV['BROWSER'] =~ /true/i
  end

  def headless?
    @headless
  end

  def browser_obj
    if headless?
      require 'celerity'
      browser = Celerity::Browser
      Celerity.index_offset = 0
      puts "Running Headless"
    else
      require "watir-webdriver"
      browser = Watir::Browser
      puts "Running in a Browser"
    end
    browser
  end

  def browser_type
    unless headless?
      if ENV['CHROME']
        puts "Using Chrome"
        return :chrome
      elsif ENV['IE']
        puts "Using IE"
        return :ie
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