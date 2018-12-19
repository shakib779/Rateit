class CreateBookreps < ActiveRecord::Migration[5.1]
  def change
    create_table :bookreps do |t|
      t.text :comment
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
