class AddBookIdToBookreviews < ActiveRecord::Migration[5.1]
  def change
    add_column :bookreviews, :book_id, :integer
  end
end
