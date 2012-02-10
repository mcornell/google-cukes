require '../pages/google_search_page'

Given /^I am at Google's Search Page$/ do
  @page = GoogleSearchPage.new(@browser, true)
end

When /^I enter "([^\"]*)" into the search box$/ do |search_item|
  @page.search_box = search_item
end

When /^I click search$/ do
  @page.search
end

When /^I search for (.*)$/ do |site|
  step %{I enter "#{site}" into the search box}
  step %{I click search}
end

require '../pages/google_search_results_page'

Then /^I am on the search result page$/ do
  @page = GoogleSearchResultsPage.new(@browser, true)
end

When /^I see (.*) as the first unsponsored result$/ do |site|
  first_result = @page.search_results_items[0]
  result_part = GoogleSearchResultPart.new(@browser, first_result)
  result_part.result_url.should include 'site'
end