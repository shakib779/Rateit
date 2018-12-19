class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.string :release_year
      t.integer :user_id

      t.timestamps
    end
  end
end
