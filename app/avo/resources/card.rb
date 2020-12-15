module Avo
  module Resources
    class Card < Resource
      def initialize
        @title = :title
        @search = %i[title subtitle body]

        #@includes = []
        @default_view_type = :grid
      end

      fields do
        id
        text :title, required: true, link_to_resource: true
        text :subtitle
        trix :body, always_show: false
        textarea :body,
                 hide_on: %i[show edit],
                 format_using: ->(value) { ActionView::Base.full_sanitizer.sanitize(value).truncate 120 }
        text :image_url, is_image: true, hide_on: %i[index show edit]
        text :excerpt, hide_on: %i[show edit index] do |model|
          begin
            ActionView::Base.full_sanitizer.sanitize(model.body).truncate 120
          rescue => exception
            ''
          end
        end
      end

      # These fields are a reference on the already configured fields above
      grid do
        preview :image_url
        title :title
        body :excerpt
      end
    end
  end
end
