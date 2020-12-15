require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test 'blank title raises error' do
    assert_raises(ActiveRecord::RecordInvalid) { Card.create!(title: '') }
  end

  test 'content is copied (and stripped) to body' do
    card = Card.create(title: 'title', content: '<b>my content</b>')
    assert card.body = 'my content'
  end
end
