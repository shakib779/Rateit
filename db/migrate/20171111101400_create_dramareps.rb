class CreateDramareps < ActiveRecord::Migration[5.1]
  def change
    create_table :dramareps do |t|
      t.text :comment
      t.integer :drama_id
      t.integer :user_id

      t.timestamps
    end
  end
end
