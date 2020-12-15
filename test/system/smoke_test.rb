require 'application_system_test_case'

# These type of tests (ApplicationSystemTestCase) use an actual web browser, and auto-control it to do things like navigate to
# pages and click buttons and links. These tests are slow, but excercise the entire app
# from browser to Rails to database. So we use them for specific flows that absolutely need to work
# in a production system like login, posting content, etc.

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
