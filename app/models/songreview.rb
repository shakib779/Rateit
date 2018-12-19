class Songreview < ApplicationRecord
	
	validates :user_id, :uniqueness => { :scope => :song_id }

	belongs_to :user
	belongs_to :song
end
