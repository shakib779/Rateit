class AddUserIdToBookreviews < ActiveRecord::Migration[5.1]
  def change
    add_column :bookreviews, :user_id, :integer
  end
end
