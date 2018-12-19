class MoviereviewsController < ApplicationController
	before_action :find_movie
	before_action :find_moviereview, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	$r = 0
	$c = 0

	def new
		@moviereview = Moviereview.new
	end
	
	def create
		@moviereview = Moviereview.new(moviereview_params)
		@moviereview.movie_id =@movie.id
		@moviereview.user_id = current_user.id

		if @moviereview.rating > 5 || @moviereview.rating < 0
			Moviereview.last.destroy
			render 'edit'
		elsif @moviereview.save
			redirect_to movie_path(@movie)
		else
			flash[:success] = "Users may only write one review per Movie."
			redirect_to movie_path(@movie)
		end	
	end

	def edit
		if current_user != @moviereview.user
   			 redirect_to movie_path(@movie)
  		end
  		$r = @moviereview.rating
  		$c = @moviereview.comment
	end

	def update 
		if @moviereview.update(moviereview_params)
			if(@moviereview.rating > 5 || @moviereview.rating < 0)
				@moviereview.update_attribute(:rating, $r)
				@moviereview.update_attribute(:comment, $c)
				flash[:success] = "Valid Rating is from 1 to 5"
				redirect_to movie_path(@movie)
			else
				redirect_to movie_path(@movie)
			end
		else 
			render 'edit'
		end		
	end

	def destroy
		@moviereview.destroy
		redirect_to movie_path(@movie)
	end	
	
	private

		def moviereview_params
			 params.require(:moviereview).permit(:rating,:comment)
		end	

		def find_movie
			@movie = Movie.find(params[:movie_id])
	 	end

	 	def find_moviereview
	 		@moviereview = Moviereview.find(params[:id])
	 	end	
end
