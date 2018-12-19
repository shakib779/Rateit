class Dramareview < ApplicationRecord

	validates :user_id, :uniqueness => { :scope => :drama_id }

	belongs_to :user
	belongs_to :drama  
end
