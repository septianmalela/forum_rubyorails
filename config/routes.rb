Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "forum_threads#index"

  	resources :users
  	resources :admin
  	resources :forum_threads, only: [:show, :new, :create] do member do  
      patch 'like_thread'
      patch 'dislike_thread'
    end

  	  resources :forum_posts, only: [:create]
  end

end
