class AddBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table "links", force: :cascade do |t|
      t.string "title"
      t.string "page"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "active"
    end
  end
end
