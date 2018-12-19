class AddAttachmentSongImgToSongs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :songs do |t|
      t.attachment :song_img
    end
  end

  def self.down
    remove_attachment :songs, :song_img
  end
end
