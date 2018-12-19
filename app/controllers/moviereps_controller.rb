class MovierepsController < ApplicationController
	before_action :find_movie
	before_action :find_movierep, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	
	def new
		@movierep = Movierep.new
	end
	
	def create
		@movierep = Movierep.new(movierep_params)
		@movierep.movie_id =@movie.id
		@movierep.user_id = current_user.id

		if @movierep.save
			redirect_to movie_path(@movie)
		else
			redirect_to movie_path(@movie)
		end	
	end

	def edit
		if current_user != @movierep.user 
   			 redirect_to movie_path(@movie)
  		end
	end

	def update
		if @movierep.update(movierep_params)
			redirect_to movie_path(@movie)
		else 
			render 'edit'
		end		
	end
	
	def destroy
		@movierep.destroy
		redirect_to movie_path(@movie)
	end	
	private

		def movierep_params
			 params.require(:movierep).permit(:comment)
		end	

		def find_movie
			@movie = Movie.find(params[:movie_id])
	 	end

	 	def find_movierep
	 		@movierep = Movierep.find(params[:id])
	 	end	
end
