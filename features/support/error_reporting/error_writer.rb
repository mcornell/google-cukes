module ErrorWriter

  def scenario_name(scenario, popup=false)
    if scenario.instance_of?(Cucumber::Ast::OutlineTable::ExampleRow)
      scenario_name = scenario.scenario_outline.name.gsub(/[^\w\-]/, ' ')
      scenario_name += "-Example#{scenario.name.gsub(/\s*\|\s*/, '-')}".chop
    else
      scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')
    end
    if popup
      scenario_name = "popup-#{scenario_name}"
    end
    scenario_name
  end

  def file_name(region, scenario_name)
    time = Time.now.strftime("%Y-%m-%d-%H%M%S")
    #Windows has file name limits
    "#{region}-#{time}-#{scenario_name}".slice(0, 250).gsub(/[\,\/]/, '.')
  end

  def write_errors(region, scenario, browser, popup=false)
    Dir.mkdir("error_pages") unless File.directory?("error_pages")

    scenario_name = scenario_name(scenario, popup)

    file_name = file_name(region, scenario_name)
    File.open("error_pages/#{file_name}.txt", 'wb') { |fh|
      fh.write browser.text.to_s
    }

    File.open("error_pages/#{file_name}.html", 'wb') { |fh|
      fh.write browser.html.to_s
    }

    capture_screenshot(browser, file_name)
    puts "\nScenario failed: #{scenario_name}\n"
    puts "\tat URL: #{browser.url}"
  end

end

World(ErrorWriter)

