class Drama < ApplicationRecord
	
	belongs_to :user
	has_many :dramareviews
	has_many :dramareps

	has_attached_file :drama_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :drama_img, content_type: /\Aimage\/.*\z/

	def self.search(search)
  		if search
   			@drama = Drama.all.where('title LIKE ?', "%#{search}%").order('created_at DESC')
 		else
   			@drama = Drama.all.order('created_at DESC') 
 		end
	end

end
