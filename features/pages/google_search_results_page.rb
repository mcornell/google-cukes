require File.dirname(__FILE__) + '/../support/watir-page-helper-support/missing_page_helpers'

class GoogleSearchResultsPage < GoogleSearchPage
  include MissingPageHelpers

  ol :search_results, :id => 'rso'

end