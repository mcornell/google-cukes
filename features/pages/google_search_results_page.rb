require File.dirname(__FILE__) + '/../support/watir-page-helper-support/missing_page_helpers'
require File.dirname(__FILE__) + '/../support/watir-page-helper-support/page_helper_parents'

class GoogleSearchResultsPage < GoogleSearchPage
  include MissingPageHelpers
  include PageHelperParents

  div :main, :id => 'main'
  ol :search_results, :id => 'rso', :parent => "main_div"

end