class BooksController < ApplicationController
	
	before_action  :find_book, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :edit]

	def index
		@book = Book.all
  		if params[:search]
    		@book = Book.search(params[:search]).order("created_at DESC")
  		else
    		@book = Book.all.order('created_at DESC')
  		end
	end

	def bytitle
		@book = Book.all
  		if params[:search]
    		@book = Book.search(params[:search]).order("title")
  		else
    		@book = Book.all.order('title')
  		end
	end

	def byyear
		@book = Book.all
  		if params[:search]
    		@book = Book.search(params[:search]).order("publish_year DESC")
  		else
    		@book = Book.all.order('publish_year DESC')
  		end
	end

	def byrating
		@book = Book.all
		@book.each do |book|
			if book.bookreviews.blank?
		   		@average_bookreview = 0
			else
				@average_bookreview = book.bookreviews.average(:rating).round(2)
			end
			book.update_attribute(:avgrating, @average_bookreview )
		end
  		if params[:search]
    		@book = Book.search(params[:search]).order("avgrating DESC")
  		else
    		@book = Book.all.order('avgrating DESC')
  		end
	end

	def show
		@us = User.all
		if @book.bookreviews.blank?
		   @average_bookreview = 0
		else
			@average_bookreview = @book.bookreviews.average(:rating).round(2)
		end	
		
	end

	def new
		@book = current_user.books.build
	end	

	def create
		@book = current_user.books.build(book_params)
		if @book.save
			redirect_to books_path
		else
			render 'new'
		end
	end

	def edit
		if current_user != @book.user && current_user.usertype != 779
   			 redirect_to book_path(@book)
  		end
	end

	def update
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
    	redirect_to books_path
	end

	private 
		def book_params
			params.require(:book).permit(:title, :publish_year, :author, :book_img, :avgrating)
		end

		def find_book
			@book = Book.find(params[:id])
		end
end
