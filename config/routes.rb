Rails.application.routes.draw do

  get 'homes/top'
  get 'homes/about'
  root to: "homes#top"

  # 管理者
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/session"
  }

  namespace :admin do
    # get 'comments/index'
    # get 'comments/show'
    # get 'comments/edit'
    resources :comments
  end
  namespace :admin do
    # get 'games/index'
    # get 'games/show'
    # get 'games/edit'
    resources :games
  end
  namespace :admin do
    # get 'questions/index'
    # get 'questions/show'
    # get 'questions/edit'
    resources :questions
  end

  namespace :admin do
    # get 'groups/index'
    # get 'groups/show'
    # get 'groups/edit'
    resources :groups
  end

  #ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :public do
    # get 'comments/index'
    # get 'comments/show'
    # get 'comments/edit'
    resources :comments
  end
  namespace :public do
    # get 'bookmarks/index'
    # get 'bookmarks/show'
    # get 'bookmarks/edit'
    resources :bookmarks
  end
  namespace :public do
    # get 'games/index'
    # get 'games/show'
    resources :games
  end

  namespace :public do
    # get 'questions/index'
    # get 'questions/show'
    resources :questions
  end

  namespace :public do
    # get 'groups/index'
    # get 'groups/show'
    # get 'groups/edit'
    resources :groups
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
