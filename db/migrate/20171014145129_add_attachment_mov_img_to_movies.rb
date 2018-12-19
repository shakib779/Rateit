class AddAttachmentMovImgToMovies < ActiveRecord::Migration[5.1]
  def self.up
    change_table :movies do |t|
      t.attachment :mov_img
    end
  end

  def self.down
    remove_attachment :movies, :mov_img
  end
end
