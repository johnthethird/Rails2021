class CreateAppConfigsTable < ActiveRecord::Migration[6.1]
  def change
    create_table "app_configs" do |t|
      t.string "var", null: false
      t.text "value"
      t.timestamps

      t.index ["var"], name: "index_app_configs_on_var", unique: true
    end
  end
end
