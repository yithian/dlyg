Dlyg::Application.routes.draw do
  resources :games do
    member do
      post 'roll_dice'
      put 'cast_shadow'
      put 'shed_light'
    end
  end

  root :to => 'games#index'

  # See how all your routes lay out with "rake routes"
end
