# frozen_string_literal: true

class AddGroups < ActiveRecord::Migration[7.0]
  def change
    create_table 'groups', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
      t.string 'name'
      t.string 'notes'
      t.datetime 'created_at', precision: 6, null: false
      t.datetime 'updated_at', precision: 6, null: false
    end
  end
end
