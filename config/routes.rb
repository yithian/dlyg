Dlyg::Application.routes.draw do
  devise_for :users

  resources :games do
    member do
      post 'roll_dice'
      put 'cast_shadow'
      put 'shed_light'
      put 'invite'
      put 'uninvite'
    end

    resources :play, :only => [:create, :update, :destroy]
    
    resources :result do
      member do
        put 'recall'
      end
    end
  end

  root :to => 'games#index'

  # See how all your routes lay out with "rake routes"
end
