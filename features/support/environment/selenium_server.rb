require 'selenium/server'

class SeleniumServer

  attr_accessor :server

  SELENIUM_SERVER_JAR = File.dirname(__FILE__) + '/../../../vendor/lib/selenium-server-standalone-2.19.0.jar'

  def start_server
    @server = Selenium::Server.new(SELENIUM_SERVER_JAR, :background => true)
    @server.start
    puts "Started Selenium Server: #{@server}"
  end

  def stop_server
    @server.stop
    puts "Stopped Selenium Server: #{@server}"
  end
end