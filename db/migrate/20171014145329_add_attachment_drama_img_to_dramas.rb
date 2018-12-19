class AddAttachmentDramaImgToDramas < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dramas do |t|
      t.attachment :drama_img
    end
  end

  def self.down
    remove_attachment :dramas, :drama_img
  end
end
