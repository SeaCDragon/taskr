Rails.application.routes.draw do
	root 'basic_pages#home'
  get 'basic_pages/home'
  get 'basic_pages/about'
  get 'basic_pages/help'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
