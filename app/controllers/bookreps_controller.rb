class BookrepsController < ApplicationController
	before_action :find_book
	before_action :find_bookrep, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	
	def new
		@bookrep = Bookrep.new
	end
	
	def create
		@bookrep = Bookrep.new(bookrep_params)
		@bookrep.book_id =@book.id
		@bookrep.user_id = current_user.id

		if @bookrep.save
			redirect_to book_path(@book)
		else
			redirect_to book_path(@book)
		end	
	end

	def edit
		if current_user != @bookrep.user 
   			 redirect_to book_path(@book)
  		end
	end

	def update
		if @bookrep.update(bookrep_params)
			redirect_to book_path(@book)
		else 
			render 'edit'
		end		
	end
	
	def destroy
		@bookrep.destroy
		redirect_to book_path(@book)
	end	
	private

		def bookrep_params
			 params.require(:bookrep).permit(:comment)
		end	

		def find_book
			@book = Book.find(params[:book_id])
	 	end

	 	def find_bookrep
	 		@bookrep = Bookrep.find(params[:id])
	 	end	
end
