class AddDramaIdToDramareviews < ActiveRecord::Migration[5.1]
  def change
    add_column :dramareviews, :drama_id, :integer
  end
end
