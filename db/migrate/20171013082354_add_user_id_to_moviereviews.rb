class AddUserIdToMoviereviews < ActiveRecord::Migration[5.1]
  def change
    add_column :moviereviews, :user_id, :integer
  end
end
