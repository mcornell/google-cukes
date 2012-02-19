require File.dirname(__FILE__) + '/../pages/google_search_page'

Given /^I am at Google's Search Page$/ do
  @page = GoogleSearchPage.new(@browser, true)
end

When /^I enter "([^\"]*)" into the search box$/ do |search_item|
  @page.search_box = search_item
end

When /^I click search$/ do
  if @page.search_button.visible?
    @page.search
  else
    @page.instant_search
  end
end

When /^I search for (.*)$/ do |site|
  step %{I enter "#{site}" into the search box}
  step %{I click search}
end

require File.dirname(__FILE__) + '/../pages/google_search_results_page'

Then /^I am on the search result page$/ do
  @page = GoogleSearchResultsPage.new(@browser)
end

When /^I see (.*) as the first unsponsored result$/ do |site|
  puts @page.search_results_items
  first_result = @page.search_results_items[0]
  result_part = GoogleSearchResultPart.new(@browser, first_result)
  result_part.result_url.should include site
end