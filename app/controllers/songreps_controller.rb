class SongrepsController < ApplicationController
	before_action :find_song
	before_action :find_songrep, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	
	def new
		@songrep = Songrep.new
	end
	
	def create
		@songrep = Songrep.new(songrep_params)
		@songrep.song_id =@song.id
		@songrep.user_id = current_user.id

		if @songrep.save
			redirect_to song_path(@song)
		else
			redirect_to song_path(@song)
		end	
	end

	def edit
		if current_user != @songrep.user 
   			 redirect_to song_path(@song)
  		end
	end

	def update
		if @songrep.update(songrep_params)
			redirect_to song_path(@song)
		else 
			render 'edit'
		end		
	end
	
	def destroy
		@songrep.destroy
		redirect_to song_path(@song)
	end	
	private

		def songrep_params
			 params.require(:songrep).permit(:comment)
		end	

		def find_song
			@song = Song.find(params[:song_id])
	 	end

	 	def find_songrep
	 		@songrep = Songrep.find(params[:id])
	 	end	
end
