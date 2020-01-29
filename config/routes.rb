Rails.application.routes.draw do
	# Root
	root 'basic_pages#home' #root_path

	# Basic Pages
  get '/about', to: 'basic_pages#about' #about_path
  get '/help',  to: 'basic_pages#help' #help_path

	# Users
	get  '/signup', to: 'users#new' #signup_path
	post '/signup', to: 'users#create' #signup_path
	resources :users
	#Controller Methods made available: show, edit, index, update, destroy
	#RESTful Equivalents respectively:  GET   GET   GET    PATCH   DELETE

	# Sessions (Login/Logout)
	get    '/login',  to: 'sessions#new'
	post   '/login',  to: 'sessions#create'
	delete '/logout', to: 'sessions#destroy'

	# Activation
	resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
