Rails.application.routes.draw do

  get 'home/index'

  devise_for :users
  get '/users/new', to: 'users#new'
  get '/users/:id', to: 'users#show', as: 'users_show'
  put '/users', to: 'users#create'
  delete '/user/delete', to: 'users#destroy', as: 'delete_user'
  #put '/users/:user_id/games', to: 'find#games', as: 'find_game'
  post '/games', to: 'games#join', as: 'games_join'
  put '/games/:id', to: 'games#move', as: 'game'
  get 'games/:id', to: 'games#show', as: 'game_show'
  get '/games', to: 'games#index'
  root to: "users#index"

  # resources :games


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
