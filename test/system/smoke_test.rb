require 'application_system_test_case'

class SmokeTest < ApplicationSystemTestCase
  test 'visiting all the pages' do
    visit root_url
    assert_selector 'h1', text: 'Find a Spot to Shred'
    click_on 'About'
    assert_selector 'h1', text: 'Technologies'
    click_on 'Cards'
    assert page.has_selector?('h1.title')
    click_on 'Search'
    assert_selector 'h1', text: 'Search'
    fill_in 'q', with: 'card1'
    assert_selector 'a', text: 'Card1'
  end
end
