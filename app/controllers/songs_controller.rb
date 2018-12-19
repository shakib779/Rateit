class SongsController < ApplicationController
	before_action  :find_song, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	def index
		@song = Song.all
  		if params[:search]
    		@song = Song.search(params[:search]).order("created_at DESC")
  		else
    		@song = Song.all.order('created_at DESC')
  		end
	end

	def bytitle
		@song = Song.all
  		if params[:search]
    		@song = Song.search(params[:search]).order("title")
  		else
    		@song = Song.all.order('title')
  		end
	end

	def byyear
		@song = Song.all
  		if params[:search]
    		@song = Song.search(params[:search]).order("release_year DESC")
  		else
    		@song = Song.all.order('release_year DESC')
  		end
	end

	def byrating
		@song = Song.all
		@song.each do |song|
			if song.songreviews.blank?
		   		@average_songreview = 0
			else
				@average_songreview = song.songreviews.average(:rating).round(2)
			end
			song.update_attribute(:avgrating, @average_songreview )
		end
  		if params[:search]
    		@song = Song.search(params[:search]).order("avgrating DESC")
  		else
    		@song = Song.all.order('avgrating DESC')
  		end
	end

	def show
		@us = User.all
		if @song.songreviews.blank?
		   @average_songreview = 0
		else
			@average_songreview = @song.songreviews.average(:rating).round(2)
		end	
	end

	def new
		@song = current_user.songs.build
	end	

	def create
		@song = current_user.songs.build(song_params)
		if @song.save
			redirect_to songs_path
		else
			render 'new'
		end
	end

	def edit
		if current_user != @song.user && current_user.usertype != 779
   			 redirect_to song_path(@song)
  		end
	end

	def update
		if @song.update(song_params)
			redirect_to song_path(@song)
		else
			render 'edit'
		end
	end

	def destroy
		@song.destroy
    	redirect_to songs_path
	end

	private 
		def song_params
			params.require(:song).permit(:title, :release_year, :artist, :song_img, :avgrating)
		end

		def find_song
			@song = Song.find(params[:id])
		end
end
