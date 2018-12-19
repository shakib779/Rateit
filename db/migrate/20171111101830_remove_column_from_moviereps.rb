class RemoveColumnFromMoviereps < ActiveRecord::Migration[5.1]
  def change
    remove_column :moviereps, :book_id, :integer
  end
end
