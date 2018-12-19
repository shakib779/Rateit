class CreateSongreps < ActiveRecord::Migration[5.1]
  def change
    create_table :songreps do |t|
      t.text :comment
      t.integer :song_id
      t.integer :user_id

      t.timestamps
    end
  end
end
