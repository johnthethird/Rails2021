class CardFullTextSearch < ActiveRecord::Migration[6.1]
  def self.up
    execute(<<-SQL.strip)
      DROP index IF EXISTS cards_title_fts_idx;
      CREATE index cards_title_fts_idx
        ON cards
        USING gin(to_tsvector('english', "cards"."title"::text));
      DROP index IF EXISTS cards_subtitle_fts_idx;
      CREATE index cards_subtitle_fts_idx
        ON cards
        USING gin(to_tsvector('english', "cards"."subtitle"::text));
      DROP index IF EXISTS cards_body_fts_idx;
      CREATE index cards_body_fts_idx
        ON cards
        USING gin(to_tsvector('english', "cards"."body"::text));
    SQL
  end

  def self.down
    execute(<<-SQL.strip)
      DROP index IF EXISTS cards_title_fts_idx;
      DROP index IF EXISTS cards_subtitle_fts_idx;
      DROP index IF EXISTS cards_body_fts_idx;
    SQL
  end
end
