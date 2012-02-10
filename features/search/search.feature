Feature: Search the Internets with Google

  As a geek, I want to search the Internet to find out stuff that is awesome.

  Scenario Outline: When I search for a specific site on the internet, I get that site
    Given I am at Google's Search Page
    When I search for <site>
    Then I am on the search result page
     And I see <site> as the first unsponsored result

  Examples:
    |site|
    |github |
#    |stackoverflow |
#    |yahoo         |