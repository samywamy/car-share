Rails.application.routes.draw do
  	resources :cars
  	devise_for :users

  	resources :spaces do
	  resources :cars
	end

  	resources :spaces do
	  resources :users
	end

	resources :users do
	  resources :spaces
	end
end
