class AddUserIdToSongreviews < ActiveRecord::Migration[5.1]
  def change
    add_column :songreviews, :user_id, :integer
  end
end
