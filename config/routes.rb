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

    resources :plays, :only => [:create, :update, :destroy]

    resources :results do
      member do
        put 'recall'
      end
    end

    resources :characters, :except => [:index, :new, :create, :destroy]
  end

  get '/about' => 'static#about', :as => 'about'

  root :to => 'games#index'

  # See how all your routes lay out with "rake routes"
end
