class AddUserIdToDramareviews < ActiveRecord::Migration[5.1]
  def change
    add_column :dramareviews, :user_id, :integer
  end
end
