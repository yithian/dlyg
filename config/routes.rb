Dlyg::Application.routes.draw do
  resources :results

  devise_for :users

  resources :games do
    member do
      post 'roll_dice'
      put 'cast_shadow'
      put 'shed_light'
      put 'invite'
      put 'uninvite'
    end
    
    resource :result
  end

  root :to => 'games#index'

  # See how all your routes lay out with "rake routes"
end
