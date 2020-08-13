  Rails.application.routes.draw do
 
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions',
  }
  resources :users, only:[:show] do
  end
  
  resources :credit_cards, only:[:new, :show] do
    collection do
      post 'show', to: 'credit_cards#show'
      post 'add', to: 'credit_cards#add'
      post 'delete', to: 'credit_cards#delete'
    end
  end

  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: "items#index"
  resources :users, only:[:show]
  resources :items, only:[:index, :new, :create, :show, :edit, :update, :destroy] do
    resources :purchases, only:[:index] do
      collection do
        post 'pay', to: 'purchases#pay'
        get 'confirmation', to: 'purchases#confirmation'
      end
    end
  end
end
