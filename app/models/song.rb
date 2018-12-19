class Song < ApplicationRecord
	
	belongs_to :user
	has_many :songreviews
	has_many :songreps

	
	has_attached_file :song_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :song_img, content_type: /\Aimage\/.*\z/

	def self.search(search)
  		if search
   			@song = Song.all.where('title LIKE ?', "%#{search}%").order('created_at DESC')
  		else
   			@song = Song.all.order('created_at DESC') 
  		end
	end

end
