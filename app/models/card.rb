require 'textacular/searchable'

class Card < ApplicationRecord
  extend Searchable(:title, :subtitle, :body)
  has_rich_text :content

  # Note we now have access to these scopes
  # Card.all.with_rich_text_content # Preload the content without attachments.
  # Card.all.with_rich_text_content_and_embeds # Preload both content and attachments.

  before_save :copy_content_to_body

  validates :title, presence: true

  # The rich text from the editor comes in as content attribute,
  # copy that over to body attribute so we can do full text search on it
  def copy_content_to_body
    self.body = self.content.to_plain_text
  end

  def image_or_default
    self.image_url || 'https://via.placeholder.com/150?text=placeholder'
  end
end
