class DramareviewsController < ApplicationController
	before_action :find_drama
	before_action :find_dramareview, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	$r = 0
	$c = 0

	def new
		@dramareview = Dramareview.new
	end
	
	def create
		@dramareview = Dramareview.new(dramareview_params)
		@dramareview.drama_id =@drama.id
		@dramareview.user_id = current_user.id

		if @dramareview.rating > 5 || @dramareview.rating < 0
			Dramareview.last.destroy
			render 'edit'
		elsif @dramareview.save
			redirect_to drama_path(@drama)
		else
			flash[:success] = "Users may only write one review per Drama."
			redirect_to drama_path(@drama)
		end	
	end

	def edit
		if current_user != @dramareview.user
   			 redirect_to drama_path(@drama)
  		end
  		$r = @dramareview.rating
  		$c = @dramareview.comment
	end

	def update 
		if @dramareview.update(dramareview_params)
			if(@dramareview.rating > 5 || @dramareview.rating < 0)
				@dramareview.update_attribute(:rating, $r)
				@dramareview.update_attribute(:comment, $c)
				flash[:success] = "Valid Rating is from 1 to 5"
				redirect_to drama_path(@drama)
			else
				redirect_to drama_path(@drama)
			end
		else 
			render 'edit'
		end		
	end

	def destroy
		@dramareview.destroy
		redirect_to drama_path(@drama)
	end	
	
	private

		def dramareview_params
			 params.require(:dramareview).permit(:rating,:comment)
		end

		def find_drama
			@drama = Drama.find(params[:drama_id])
	 	end

	 	def find_dramareview
	 		@dramareview = Dramareview.find(params[:id])
	 	end	

end
