# -*- encoding : utf-8 -*-
Realty::Application.routes.draw do

  get "exit", to: "admin/users#exit"
  get "yrl", to: "main#yrl"
  get "sitemap", to: "main#sitemap"
  get "admin", to: "admin/users#login"
  get "otzivi", to: "main#feedbacks"
  get "realty/:id", to: "main#realty"
  get ":alt", to: "main#post"
  get "page/:alt", to: "main#page"
  get "page/:alt", to: "main#page"
  post "page/:alt", to: "main#page"
  get "tag/:tag", to: "main#posts"
  get "category/:category", to: "main#posts"
  match "posts/:page", to: "posts#index"

  namespace :admin do

    get "settings/edit"
    post "settings/update"
    put "settings/update"

    resources :users do
      collection do
        get "login"
        get "exit"
        post "auth"
      end
    end

    resources :comments do
      collection do
        get "approve"
      end
    end

    resources :feedbacks do
      collection do
        get "approve"
      end
    end

    resources :houses do
      collection do
        get "approve"
      end
    end

    resources :orders do
      collection do
        get "approve"
      end
    end

    resources :user do
      collection do
        post "create"
      end
    end

    resources :adverts
    resources :links
    resources :categories
    resources :contacts
    resources :metros
    resources :posts
    resources :photos
    resources :pages
  end

  get "main/contact_form"
  get "main/posts"
  get "main/feedbacks"

  get "main/realty"
  post "main/realty"

  get "main/post"
  post "main/post"

  get "main/catalog"
  post "main/catalog"

  get "main/add_realty"
  post "main/add_realty"

  get "main/page"
  post "main/page"

  get "main/add_feedbacks"
  post "main/add_feedbacks"

  post "main/contact"

  get "tags/:tag", to: "articles#index", as: :tag

  mount Ckeditor::Engine => "/ckeditor"

  root :to => "main#posts"
  match "*a", :to => "main#page"

end
