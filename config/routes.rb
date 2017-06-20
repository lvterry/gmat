Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create', as: 'login'

  get 'update_mobile', to: 'users#update_mobile', as: 'update_mobile'

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/vip'

  get 'welcome/uptoken'

  resources :posts
  resources :users
  resources :exercises do
    collection do
      get :search
    end
  end

  get 'meetings', to: 'meetings#index'

  root to: 'welcome#index'

  get 'courses', to: 'courses#index'

  get 'courses/free', to: 'courses#free', as: 'free_courses'

  get 'courses/free/archive', to: 'courses#free_archive', as: 'free_courses_archive'

  get 'courses/:id', to: 'courses#show', as: 'course_show'


  namespace :admin do
    #get 'about/:id/edit', to: 'about#edit'
    resources :posts, :tags, :about, :vip,
      :teachers, :attachments, :slides, :meetings,
      :courses, :exercises, :users

    resources :user_groups do
      member do
        post :add_users
      end
    end


    post "vip/flows", to: 'vip#flows'
    post "vip/questions", to: 'vip#questions'

    root to: 'courses#index'

    #get "posts/:id/delete_attachment", to: 'posts#delete_attachment'
  end
end
