Rails.application.routes.draw do
  devise_for :users
  
  
  get 'static/home'
  get 'static/info'
  get 'static/admin'
  get 'books/bytitle'
  get 'books/byyear'
  get 'books/byrating'
  get 'movies/bytitle'
  get 'movies/byyear'
  get 'movies/byrating'
  get 'songs/bytitle'
  get 'songs/byyear'
  get 'songs/byrating'
  get 'dramas/bytitle'
  get 'dramas/byyear'
  get 'dramas/byrating'

  resources :books do 
  	resources :bookreviews
    resources :bookreps
  end	
  resources :movies do 
  	resources :moviereviews
    resources :moviereps
  end	
  resources :songs do 
  	resources :songreviews
    resources :songreps
  end	
  resources :dramas do 
  	resources :dramareviews
    resources :dramareps
  end	

  root 'static#home'
end
