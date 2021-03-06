Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create', as: 'login'

  get '/logout', to: 'sessions#destroy', as: 'logout'

  get 'update_mobile', to: 'users#update_mobile', as: 'update_mobile'

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/vip'

  get 'welcome/uptoken'

  resources :posts, :users, :exams, :temp_users, :takes

  get 'exams/:id/instructions/:page_id', to: 'exams#instructions'
  get 'exams/:id/exercises/:exercise_id', to: 'exams#exercise'
  get 'exams/:id/pause', to: 'exams#pause'
  get 'exams/:id/result', to: 'exams#result'

  resources :exercises do
    collection do
      get :search
    end
  end

  get 'meetings', to: 'meetings#index'

  root to: 'welcome#index'

  get 'courses', to: 'courses#index'

  get 'courses/free', to: 'courses#free', as: 'free_courses'

  get 'courses/:id', to: 'courses#show', as: 'course_show'

  get 'user_groups/:id/join', to: 'user_groups#join'


  namespace :admin do

    root to: 'courses#index'

    get 'users/lonely', to: 'users#lonely', as: 'lonely_users'
    get 'users/search', to: 'users#search', as: 'search_users'

    resources :posts, :tags, :about, :vip,
      :teachers, :attachments, :slides, :meetings,
      :courses, :exercises, :admin_users, :labels

    resources :exams do
      collection do
        get :users
        get :takes
      end
    end

    resources :user_groups do
      member do
        post :add_users
        post :remove_user
        get :users
      end
    end

    resources :users do
      member do
        get :check_permission
      end
    end

    post "vip/flows", to: 'vip#flows'
    post "vip/questions", to: 'vip#questions'

    get 'wzkf', to: 'admin_users#index'

    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'login', to: 'sessions#destroy'

    get 'quick_exercises', to: 'exercises#quick', as: 'quick'
  end
end
