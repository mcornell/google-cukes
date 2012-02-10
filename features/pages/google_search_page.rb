class GoogleSearchPage < BasePage

  direct_url 'http://www.google.com'

  text_field :search_box, :name => 'q'
  button :old_search, :name => 'btnK'
  button :search, :name => 'btnG'

  image :title_image, :id => 'hplogo'

end