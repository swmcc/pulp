class CreateThoughts < ActiveRecord::Migration[7.0]
  def change
    create_table :thoughts, id: :uuid do |t|
      t.text :thought
      t.datetime :sparked_at

      t.timestamps
    end
  end
end
