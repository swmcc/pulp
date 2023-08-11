class CreateEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :emails, id: :uuid do |t|
      t.string :email
      t.string :app

      t.timestamps
    end
  end
end
