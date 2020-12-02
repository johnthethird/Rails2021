class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :title, null: false
      t.string :subtitle
      t.string :body
      t.string :image_url

      t.timestamps
    end

    add_index :cards, :title, unique: true
  end
end
