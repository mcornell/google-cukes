require '../support/pages/google_search'
Given /^I am at Google's Search Page$/ do
  @page = GoogleSearch.new(@browser)
  @page.goto

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