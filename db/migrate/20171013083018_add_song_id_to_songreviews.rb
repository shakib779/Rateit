class AddSongIdToSongreviews < ActiveRecord::Migration[5.1]
  def change
    add_column :songreviews, :song_id, :integer
  end
end
