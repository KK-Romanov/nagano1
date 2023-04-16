Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy] 
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_details, only: [:update]
    end
    scope module: :admin do 
    resources :homes, only: [:top]
    get "/admin" => "homes#top", as: "top"
    end
  # --------------------------------------------------------------------------
  
    # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  scope module: :public do 
  # resources :registrations
      # get "/customers/sign_up" => "registrations#new"
      # get "/customers" => "registrations#create"
  # resources :sessions
  #     get "/customers/sign_in" => "sessions#new"
  #     get "/customers/sign_in" =>  "sessions#create"
  #     get "/customers/sign_out" => "sessions#destroy"
   resources :addresses  
      get "/addresses" => "addresses#index"
      get "/addresses/:id/edit" => "addresses#edit"
      get "/addresses" => "addresses#create"
      get "/addresses/:id" => "addresses#update"
      get "/addresses/:id" => "addresses#destroy"
    resources :orders 
      get  "/orders/new" => "orders#new"
      get "/orders/confirm"  => "orders#confirm"
      get "/orders/complete" => "orders#complete"
      get "/orders" => "orders#index"
      get "/orders/:id"  => "orders#show"
      get "orders/create" 
    resources :cart_items 
      get "/cart_items" => "cart_items#index" 
      get 'cart_items/update'
      get 'cart_items/destroy'
      get 'cart_items/destroy_all'
      get 'cart_items/create'
    resources :customers 
      get "/customers/my_page" => "customers#show"
      get "/customers/information/edit"  => "customers/edit"
      get "/customers/information" => "/customers#update"
      get "/customers/unsubscribe" => "customers#unsubscribe"
      get "/customers/withdraw" => "customers#withdraw"
    resources :homes
      root to: 'homes#top'
      get "/about" => "homes#about", as: "about"
    resources :items
     get "/items" => "public/items#index", as: "lot"
     get "/items/:id" => "items#show", as: "show"
   end

  
  
  
end