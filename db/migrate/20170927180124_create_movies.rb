class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :release_year
      t.string :stars
      t.integer :user_id

      t.timestamps
    end
  end
end
