class CreateCommits < ActiveRecord::Migration[7.0]
  def change
    create_table :commits, id: :uuid do |t|
      t.string :repo_name
      t.string :sha
      t.string :message
      t.datetime :commit_date

      t.timestamps
    end
  end
end
