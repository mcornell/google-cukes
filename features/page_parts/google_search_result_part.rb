require File.dirname(__FILE__) + '/../support/watir-page-helper-support/page_helper_parents'

class GoogleSearchResultPart < BasePart
  include PageHelperParents

  div :result_container, :index => 0
  h3 :result_name, :parent => "result_container_div"
  div :result_info, :class => 's', :parent => "result_container_div"
  div :result_url, :index => 0, :parent => "result_info_div"
  span :result_desc, :class => 'st', :parent => "result_info_div"

  def part_root(browser, key)
    #Proof that you can really hack it
    @browser = key
  end
end