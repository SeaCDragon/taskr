Rails.application.routes.draw do
	root 'basic_pages#home'
  get '/about', to: 'basic_pages#about'
  get '/help', to: 'basic_pages#help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
