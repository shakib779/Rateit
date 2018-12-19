class Bookreview < ApplicationRecord
	validates :user_id, :uniqueness => { :scope => :book_id }

	belongs_to :user
	belongs_to :book
end
