Rails.application.routes.draw do
  get '/signup', to: 'users#new' #signup_path
	root 'basic_pages#home' #root_path
  get '/about', to: 'basic_pages/about' #about_path
  get '/help', to: 'basic_pages/help' #help_path
	resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
