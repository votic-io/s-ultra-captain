Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :log do
  	collection do
  		post :entry
  		get :entry
  		get :filters
  	end
  end
end
