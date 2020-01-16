Rails.application.routes.draw do
  get "/signup", to: 'users#new' #signup_path
	root 'basic_pages#home' #root_path
  get 'basic_pages/home' #basic_pages_home_url
  get 'basic_pages/about' #basic_pages_about_url
  get 'basic_pages/help' #basic_pages_help_url
	resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
