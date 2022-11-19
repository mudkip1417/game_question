Rails.application.routes.draw do

  get 'homes/top'
  get 'homes/about'
  get "search_result" => "searchs#search_result"
  root to: "homes#top"

  # 管理者
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :questions, except: [:index] do
      resource :bookmarks, only: [:create, :destroy]
    end
  end
  namespace :admin do
    resources :games
  end

  namespace :admin do
    resources :questions
    resources :questions do
      resources :comments, only: [:destroy]
    end
    get 'bookmarks' => 'questions#bookmark'
  end

  namespace :admin do
    resources :tags
  end

  namespace :admin do
    resources :groups, except: [:destroy] do
      resources :group_comments, only: [:create,:destroy]
    end
  end

  namespace :admin do
    get "search" => "searches#search"
    get "search_tag" => "questions#search_tag"
  end

  namespace :admin do
    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in', as: 'guest_sign_in'
    end

    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw/:id' => 'users#withdraw', as: 'withdraw'

    resources :users
    resources :groups
    end

  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    resources :questions, except: [:index] do
      resource :bookmarks, only: [:create, :destroy]
    end
  end
  namespace :public do
    resources :games
  end

  namespace :public do
    resources :questions
    resources :questions do
      resources :comments, only: [:create,:destroy]
    end
    get 'bookmarks' => 'questions#bookmark'
  end

  namespace :public do
    resources :tags
  end

  namespace :public do
    resources :groups, except: [:destroy] do
      resources :group_comments, only: [:create,:destroy]
    end
  end

  namespace :public do
    get "search" => "searches#search"
    get "search_tag" => "questions#search_tag"
  end

  namespace :public do
    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in', as: 'guest_sign_in'
    end

    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw/:id' => 'users#withdraw', as: 'withdraw'

    resources :users
    resources :groups do
      get "join" => "groups#join"
    end
  end



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
