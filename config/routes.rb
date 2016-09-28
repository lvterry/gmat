Rails.application.routes.draw do

  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/vip'

  get 'welcome/uptoken'

  resources :posts

  get 'meetings', to: 'meetings#index'

  root to: 'welcome#index'


  namespace :admin do
    #get 'about/:id/edit', to: 'about#edit'
    resources :posts, :tags, :about, :vip,
      :teachers, :attachments, :slides, :meetings

    post "vip/flows", to: 'vip#flows'
    post "vip/questions", to: 'vip#questions'

    root to: 'slides#index'

    #get "posts/:id/delete_attachment", to: 'posts#delete_attachment'
  end
end
