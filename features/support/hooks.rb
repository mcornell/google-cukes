Before do
  case RUBY_PLATFORM
    when /java/
      if WEBDRIVER
        puts "Creating Browser"
        @browser = BROWSER.new BROWSER_TYPE
        puts "Browser Created"
      else
        browser_opts = {}
        browser_opts[:secure_ssl] = false #our datapower source is insecure.
        if REGION_BASE_URL.downcase =~ /^https:/
          browser_opts[:proxy] = HTTP_PROXY
        end
        @browser = BROWSER.new browser_opts
      end
    else
      raise "This platform is not supported (#{RUBY_PLATFORM})"
  end
  @base_url = REGION_BASE_URL
end

After do
  @browser.close
end

After do |scenario|
  if scenario.failed?
    if WEBDRIVER
      @browser.windows.each_with_index do |window, idx|
        window.use
        if idx == 0
          write_errors([ENV['TEST_SERVER'] || 'devl'], scenario, @browser, false)
        else
          write_errors([ENV['TEST_SERVER'] || 'devl'], scenario, @browser, true)
        end
      end
    else
      write_errors([ENV['TEST_SERVER'] || 'devl'], scenario, @browser)
      write_errors([ENV['TEST_SERVER'] || 'devl'], scenario, @popup_browser, true) if @popup_browser
    end
  end
end

After('@payment') do
  puts "\nsleeping to allow payments to register"
  sleep 8
end

Before('@email_receive') do
  unless email_sleep
    sleep 30
  end
end