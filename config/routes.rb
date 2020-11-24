Rails.application.routes.draw do
  devise_for :users
  root :to => 'homes#top'
  get 'homes/about' => 'homes#about'
 
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :index] do
     member do
      put "/users/:id/hide" => "users#hide", as: 'users_hide'
    end
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
