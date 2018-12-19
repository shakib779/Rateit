class DramarepsController < ApplicationController
	before_action :find_drama
	before_action :find_dramarep, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	
	def new
		@dramarep = Dramarep.new
	end
	
	def create
		@dramarep = Dramarep.new(dramarep_params)
		@dramarep.drama_id =@drama.id
		@dramarep.user_id = current_user.id

		if @dramarep.save
			redirect_to drama_path(@drama)
		else
			redirect_to drama_path(@drama)
		end	
	end

	def edit
		if current_user != @dramarep.user 
   			 redirect_to drama_path(@drama)
  		end
	end

	def update
		if @dramarep.update(dramarep_params)
			redirect_to drama_path(@drama)
		else 
			render 'edit'
		end		
	end
	
	def destroy
		@dramarep.destroy
		redirect_to drama_path(@drama)
	end	
	private

		def dramarep_params
			 params.require(:dramarep).permit(:comment)
		end	

		def find_drama
			@drama = Drama.find(params[:drama_id])
	 	end

	 	def find_dramarep
	 		@dramarep = Dramarep.find(params[:id])
	 	end	
end
