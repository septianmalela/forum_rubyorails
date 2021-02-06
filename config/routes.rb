Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # match '*path' => redirect('/'), via: :get

  root "forum_threads#index"
  resources :admin do
    collection do
     get :table_post 
     get :table_user 
     get :table_like 
    end
  end
  
    resources :users
    resources :forum_threads, only: [:show, :new, :create] do
      resources :forum_posts, only: [:create]
  end

  resources :forum_threads do 
    resources :likes do member do
      patch 'like_thread'
      patch 'dislike_thread'
    end
      end
  end

  resources :forum_threads do member do
    patch 'true_thread'
    patch 'false_thread'
  end
end
end
