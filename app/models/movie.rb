class Movie < ApplicationRecord
	
	belongs_to :user
	has_many :moviereviews
	has_many :moviereps

	has_attached_file :mov_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :mov_img, content_type: /\Aimage\/.*\z/

	def self.search(search)
  		if search
    		@movie = Movie.all.where('title LIKE ?', "%#{search}%").order('created_at DESC')
  		else
    		@movie = Movie.all.order('created_at DESC') 
  		end
	end
	
end
