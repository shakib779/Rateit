class SongreviewsController < ApplicationController
	before_action :find_song
	before_action :find_songreview, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	$r = 0
	$c = 0

	def new
		@songreview = Songreview.new
	end
	
	def create
		@songreview = Songreview.new(songreview_params)
		@songreview.song_id =@song.id
		@songreview.user_id = current_user.id

		if @songreview.rating > 5 || @songreview.rating < 0
			Songreview.last.destroy
			render 'edit'
		elsif @songreview.save
			redirect_to song_path(@song)
		else
			flash[:success] = "Users may only write one review per Song."
			redirect_to song_path(@song)
		end	
	end

	def edit
		if current_user != @songreview.user
   			 redirect_to song_path(@song)
  		end
  		$r = @songreview.rating
  		$c = @songreview.comment
	end

	def update 
		if @songreview.update(songreview_params)
			if(@songreview.rating > 5 || @songreview.rating < 0)
				@songreview.update_attribute(:rating, $r)
				@songreview.update_attribute(:comment, $c)
				flash[:success] = "Valid Rating is from 1 to 5"
				redirect_to song_path(@song)
			else
				redirect_to song_path(@song)
			end
		else 
			render 'edit'
		end	
	end

	def destroy
		@songreview.destroy
		redirect_to song_path(@song)
	end	
	
	private

		def songreview_params
			 params.require(:songreview).permit(:rating,:comment)
		end	

		def find_song
			@song = Song.find(params[:song_id])
	 	end

	 	def find_songreview
	 		@songreview = Songreview.find(params[:id])
	 	end	
end
