class DramasController < ApplicationController
	before_action  :find_drama, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def index
		@drama = Drama.all
  		if params[:search]
    		@drama= Drama.search(params[:search]).order("created_at DESC")
  		else
    		@drama = Drama.all.order('created_at DESC')
  		end
	end

	def bytitle
		@drama = Drama.all
  		if params[:search]
    		@drama = Drama.search(params[:search]).order("title")
  		else
    		@drama = Drama.all.order('title')
  		end
	end

	def byyear
		@drama = Drama.all
  		if params[:search]
    		@drama = Drama.search(params[:search]).order("created_at DESC")
  		else
    		@drama = Drama.all.order('created_at DESC')
  		end
	end

	def byrating
		@drama = Drama.all
		@drama.each do |drama|
			if drama.dramareviews.blank?
		   		@average_dramareview = 0
			else
				@average_dramareview = drama.dramareviews.average(:rating).round(2)
			end
			drama.update_attribute(:avgrating, @average_dramareview )
		end
  		if params[:search]
    		@drama = Drama.search(params[:search]).order("avgrating DESC")
  		else
    		@drama = Drama.all.order('avgrating DESC')
  		end
	end

	def show
		@us = User.all
		if @drama.dramareviews.blank?
		   @average_dramareview = 0
		else
			@average_dramareview = @drama.dramareviews.average(:rating).round(2)
		end	
	end

	def new
		@drama = current_user.dramas.build
	end	

	def create
		@drama = current_user.dramas.build(drama_params)
		if @drama.save
			redirect_to dramas_path
		else
			render 'new'
		end
	end

	def edit
		if current_user != @drama.user && current_user.usertype != 779
   			 redirect_to drama_path(@drama)
  		end
	end

	def update
		if @drama.update(drama_params)
			redirect_to drama_path(@drama)
		else
			render 'edit'
		end
	end

	def destroy
		@drama.destroy
    	redirect_to dramas_path
	end

	private 
		def drama_params
			params.require(:drama).permit(:title, :star, :con, :drama_img, :avgrating)
		end

		def find_drama
			@drama = Drama.find(params[:id])
		end
end
