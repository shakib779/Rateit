class CreateMoviereps < ActiveRecord::Migration[5.1]
  def change
    create_table :moviereps do |t|
      t.text :comment
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
