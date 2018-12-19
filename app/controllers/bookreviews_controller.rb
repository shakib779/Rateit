class BookreviewsController < ApplicationController
	before_action :find_book
	before_action :find_bookreview, only: [:edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]
	$r = 0
	$c = 0
	
	def new
		@bookreview = Bookreview.new
	end
	
	def create
		@bookreview = Bookreview.new(bookreview_params)
		@bookreview.book_id =@book.id
		@bookreview.user_id = current_user.id

		if @bookreview.rating > 5 || @bookreview.rating < 0
			Bookreview.last.destroy
			render 'edit'
		elsif @bookreview.save
			redirect_to book_path(@book)
		else
			flash[:success] = "Users may only write one review per book."
			redirect_to book_path(@book)
		end	
	end

	def edit
		if current_user != @bookreview.user
   			 redirect_to book_path(@book)
  		end
  		$r = @bookreview.rating
  		$c = @bookreview.comment
	end

	def update
		if @bookreview.update(bookreview_params)
			if(@bookreview.rating > 5 || @bookreview.rating < 0)
				@bookreview.update_attribute(:rating, $r)
				@bookreview.update_attribute(:comment, $c)
				flash[:success] = "Valid Rating is from 1 to 5"
				redirect_to book_path(@book)
			else
				redirect_to book_path(@book)
			end
		else 
			render 'edit'
		end		
	end
	
	def destroy
		@bookreview.destroy
		redirect_to book_path(@book)
	end	
	private

		def bookreview_params
			 params.require(:bookreview).permit(:rating,:comment)
		end	

		def find_book
			@book = Book.find(params[:book_id])
	 	end

	 	def find_bookreview
	 		@bookreview = Bookreview.find(params[:id])
	 	end	

end
