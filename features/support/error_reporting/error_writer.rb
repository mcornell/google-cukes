module ErrorWriter

  def scenario_name(scenario)
    if scenario.instance_of?(Cucumber::Ast::OutlineTable::ExampleRow)
      scenario_name = scenario.scenario_outline.name.gsub(/[^\w\-]/, ' ')
      scenario_name += "-Example#{scenario.name.gsub(/\s*\|\s*/, '-')}".chop
    else
      scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')
    end
    scenario_name
  end

  def file_name(region, scenario_name)
    time = Time.now.strftime("%Y-%m-%d-%H%M%S")
    #Windows has file name limits
    "#{region}-#{time}-#{scenario_name}".slice(0, 250).gsub(/[\,\/]/, '.')
  end

  def write_errors(region, scenario, browser)
    Dir.mkdir("error_pages") unless File.directory?("error_pages")

    scenario_name = scenario_name(scenario)

    file_name = file_name(region, scenario_name)

    File.open("error_pages/#{file_name}.txt", 'wb') { |fh|
      fh.write browser.text.to_s
    }

    File.open("error_pages/#{file_name}.html", 'wb') { |fh|
      fh.write browser.html.to_s
    }

    capture_screenshot(browser, file_name)
    puts "Scenario failed: #{scenario_name}"
    puts "\tat URL: #{browser.url}"
  end

  unless HEADLESS
    def capture_screenshot(browser, file_name)
      Dir.mkdir("screenshots") unless File.directory?("screenshots")
      screenshot_location = "screenshots/#{file_name}.png"
      @browser.driver.save_screenshot screenshot_location
      embed screenshot_location, 'image/png'
    end
  else
    # Other platforms...you don't get screenshots
    def capture_screenshot(browser, file_name)
      STDERR.puts "Sorry - no screenshots on your platform yet."
    end
  end

end

World(ErrorWriter)