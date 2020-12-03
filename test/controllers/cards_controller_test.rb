require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Grab a card from our cards.yml fixtures file
    @card = cards(:one)
    @admin = users(:admin)
  end

  test "should get index" do
    get cards_url
    assert_response :success
    assert_match "Card", @response.body
  end

  test "should get show page" do
    get card_url(@card)
  
    assert_match @card.title, @response.body
    assert_select 'a', 'Edit'
  end

  test "should not allow creating" do
    assert_no_difference -> { Card.count } do
      post cards_url, params: { card: { title: 'newcardtitle'} }
    end
    assert_equal "302", @response.code
    assert flash[:alert].present? 
    assert_redirected_to root_path
  end

  test "should allow creating for logged in admin" do
    login_as(@admin)
    assert_difference -> { Card.count } do
      post cards_url, params: { card: { title: 'newcardtitle'} }
    end
    assert_response :redirect
    assert flash[:alert].blank?
  end

end