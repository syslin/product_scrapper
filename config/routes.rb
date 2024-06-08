Rails.application.routes.draw do
  resources :categories do
    resources :products, only: [:index] # Nested route to fetch products belonging to a category
  end
  resources :products, only: [:create, :update] # Nested route to fetch products belonging to a category

end
