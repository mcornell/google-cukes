if ENV['HTMLUNIT']
  require File.dirname(__FILE__) + '/environment/selenium_server'
  @selenium_server = SeleniumServer.new
  @selenium_server.start_server

  at_exit do
    @selenium_server.stop_server
  end
end

Before do
  puts "Creating Browser"
  unless HEADLESS
    @browser = BROWSER.new BROWSER_TYPE
  else
    if RUBY_PLATFORM =~ /java/
      browser_opts = {}
      browser_opts[:secure_ssl] = false
      browser_opts[:proxy] = ENV['PROXY'] if ENV['PROXY']
      @browser = BROWSER.new browser_opts
      if ENV['PROXY_USER']
        puts "setting proxy user"
        @browser.webclient.getCredentialsProvider.addCredentials ENV['PROXY_USER'], ENV['PROXY_PASS']
      end
    else
      puts "Connecting to Selenium Server"
      @browser = BROWSER.new :remote, :url => 'http://127.0.0.1:4444/wd/hub', :desired_capabilities => BROWSER_TYPE
    end
  end
  puts "Browser Created"
end

After do
  @browser.close
end

After do |scenario|
  if scenario.failed?
    write_errors([ENV['TEST_SERVER'] || 'devl'], scenario, @browser)
  end
end



