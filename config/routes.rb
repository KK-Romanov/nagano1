Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :sessions, only: [:new, :create, :destroy] 
    resources :items, only: [:index, :new, :show, :edit, :update]
    post "/items" => "/admin/items#create", as: "zaku"
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
  # addresses  
      get "/addresses" => "addresses#index"
      get "/addresses/:id/edit" => "addresses#edit"
      get "/addresses" => "addresses#create"
      get "/addresses/:id" => "addresses#update"
      get "/addresses/:id" => "addresses#destroy"
    # orders 
      get  "/orders/new" => "orders#new"
      get "/orders/confirm"  => "orders#confirm"
      get "/orders/complete" => "orders#complete"
      get "/orders" => "orders#index"
      get "/orders/:id"  => "orders#show"
      get "orders/create" 
      delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]  
    # customers 
      get "/customers/my_page" => "customers#show"
      get "/customers/information/edit"  => "customers#edit"
      patch "/customers/information" => "customers#update"
      get "/customers/unsubscribe" => "customers#unsubscribe", as: "unsubscribe"
      patch  "/customers/withdraw" => "customers#withdraw", as:"withdraw"
    resources :homes
      root to: 'homes#top'
      get "/about" => "homes#about", as: "about"
    resources :items
     get "/items" => "public/items#index", as: "lot"
     get "/items/:id" => "items#show", as: "show"
   end

  
  
  
end