class Book < ApplicationRecord

	belongs_to :user
	has_many :bookreviews
	has_many :bookreps

	has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/


	def self.search(search)
  		if search
    		@book = Book.all.where('title LIKE ?', "%#{search}%").order('created_at DESC')
  		else
   			@book = Book.all.order('created_at DESC') 
  		end
	end
	
end
