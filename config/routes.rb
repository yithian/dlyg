Dlyg::Application.routes.draw do
  resources :sessions
  resources :dice_pools do
    collection do
      post 'roll'
    end
  end

  root :to => 'sessions#index'

  # See how all your routes lay out with "rake routes"
end
