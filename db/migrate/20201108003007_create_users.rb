class CreateUsers < ActiveRecord::Migration[6.1]
  def up
    # If you dont want to learn the Rails Migration DSL, you can always just use good ol' SQL
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS citext;

      CREATE TYPE user_status_enum AS ENUM ('reader', 'editor', 'admin');

      CREATE TABLE users (
        id BIGSERIAL PRIMARY KEY,
        email citext UNIQUE CHECK(email ~* '^.+@.+\..+$' AND length(email) < 255),
        firstname citext CHECK(length(firstname) < 255),
        lastname citext CHECK(length(lastname) < 255),
        status user_status_enum NOT NULL DEFAULT 'reader',
        avatar_url text CHECK(length(avatar_url) < 255),
        created_at timestamp NOT NULL DEFAULT NOW(),
        updated_at timestamp NOT NULL DEFAULT NOW()
      );

      COMMENT ON TABLE users is 'A user of the application';
      COMMENT ON COLUMN users.email is 'Primary email address of the user.';
      COMMENT ON COLUMN users.status is 'Status of the user (reader, editor, or admin)';


    SQL

    add_index :users, :firstname
    add_index :users, :lastname
    add_index :users, :status
  end
end
