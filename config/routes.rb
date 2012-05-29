Dlyg::Application.routes.draw do
  resources :sessions do
    member do
      post 'roll_dice'
    end
  end

  root :to => 'sessions#index'

  # See how all your routes lay out with "rake routes"
end
