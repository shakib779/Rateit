class CreateDramas < ActiveRecord::Migration[5.1]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :star
      t.string :con
      t.integer :user_id

      t.timestamps
    end
  end
end
