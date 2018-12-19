class StaticController < ApplicationController
	
	def home
	end
	
	def info
	end

	def admin
		if user_signed_in?
			if current_user.usertype === 779
				@us = User.all
				@ss = params[:search]
			else
				render 'home'
			end
		else
			render 'home'
		end
	end

end
