class MoviesController < ApplicationController
	before_action  :find_movie, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	def index
		@movie = Movie.all
  		if params[:search]
    		@movie = Movie.search(params[:search]).order("created_at DESC")
  		else
    		@movie = Movie.all.order('created_at DESC')
  		end
	end

	def bytitle
		@movie = Movie.all
  		if params[:search]
    		@movie = Movie.search(params[:search]).order("title")
  		else
    		@movie = Movie.all.order('title')
  		end
	end

	def byyear
		@movie = Movie.all
  		if params[:search]
    		@movie = Movie.search(params[:search]).order("release_year DESC")
  		else
    		@movie = Movie.all.order('release_year DESC')
  		end
	end

	def byrating
		@movie = Movie.all
		@movie.each do |movie|
			if movie.moviereviews.blank?
		   		@average_moviereview = 0
			else
				@average_moviereview = movie.moviereviews.average(:rating).round(2)
			end
			movie.update_attribute(:avgrating, @average_moviereview )
		end
  		if params[:search]
    		@movie = Movie.search(params[:search]).order("avgrating DESC")
  		else
    		@movie = Movie.all.order('avgrating DESC')
  		end
	end

	def show
		@us = User.all
		if @movie.moviereviews.blank?
		   @average_moviereview = 0
		else
			@average_moviereview = @movie.moviereviews.average(:rating).round(2)
		end	
	end

	def new
		@movie = current_user.movies.build
	end	

	def create
		@movie = current_user.movies.build(movie_params)
		if @movie.save
			redirect_to movies_path
		else
			render 'new'
		end
	end

	def edit
		if current_user != @movie.user && current_user.usertype != 779
   			 redirect_to movie_path(@movie)
  		end
	end

	def update
		if @movie.update(movie_params)
			redirect_to movie_path(@movie)
		else
			render 'edit'
		end
	end

	def destroy
		@movie.destroy
    	redirect_to movies_path
	end

	private 
		def movie_params
			params.require(:movie).permit(:title, :release_year, :stars, :director, :mov_img, :avgrating)
		end

		def find_movie
			@movie = Movie.find(params[:id])
		end
end
