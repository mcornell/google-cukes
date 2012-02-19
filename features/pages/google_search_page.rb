class GoogleSearchPage < BasePage

  direct_url 'http://www.google.com'

  text_field :search_box, :name => 'q'
  button :search, :name => 'btnK'
  button :instant_search, :name => 'btnG'

  image :title_image, :id => 'hplogo'

end