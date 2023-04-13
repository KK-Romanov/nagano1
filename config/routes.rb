Rails.application.routes.draw do
  
  scope module: :admin do
    resources :sessions  
    get "/admin/sign_in" => "sessions#new"
   end
    
    scope module: :admin do
    resources :homes
    get "/admin" => "admin#top"
   end 
    
    scope module: :admin do
    resources :items
    get "/admin/items"  => "items#index"
    get "/admin/items/new"  => "items#new"
    get 'items/create'
    get "/admin/items/:id"  => "items#show"
    get "/admin/items/:id/edit"  => "items#edit"
    get "/admin/items/:id" => "items#update" 
   end

    scope module: :admin do
    resources :customers
    get "/admin/customers" => "customers#index"
    get "/admin/customers/:id" => "customers#show"
    get "/admin/customers/:id/edit" => "customers#edit"
    resources :orders
    get "/admin/orders/:id" => "orders#show"
    end   
    
    scope module: :admin do
    resources :genres
    get "/admin/genres" => "genres#index"
    get "/admin/genres/:id/edit" => "genres#edit"
    end
    
    scope module: :admin do
    resources :order_details, only: [:update]
    end
  
  # namespace :admin do
  #   get 'order_details/update'
  # end
  # namespace :admin do
  #   get 'orders/show'
  #   get 'orders/update'
  # end
  # namespace :admin do
  #   get 'customers/index'
  #   get 'customers/show'
  #   get 'customers/edit'
  #   get 'customers/update'
  # end
  # namespace :admin do
  #   get 'genres/index'
  #   get 'genres/create'
  #   get 'genres/edit'
  #   get 'genres/update'
  # end
  # namespace :admin do
  #   get 'items/index'
  #   get 'items/new'
  #   get 'items/create'
  #   get 'items/show'
  #   get 'items/edit'
  #   get 'items/update'
  # end
  # namespace :admin do
  #   get 'homes/top'
  # end
  # end
  
  
  
  # --------------------------------------------------------------------------
  
  scope module: :public do 
    resources :registrations
    get "/customers/sign_up" => "registrations#new"
    get "/customers" => "registrations#create"
    end
  
  scope module: :public do 
     resources :sessions
    get "/customers/sign_in" => "sessions#new"
	  get "/customers/sign_in" =>  "sessions#create"
    get "/customers/sign_out" => "sessions#destroy"
   end
    
  scope module: :public do
  resources :addresses  
    get "/addresses" => "addresses#index"
    get "/addresses/:id/edit" => "addresses#edit"
    get "/addresses" => "addresses#create"
    get "/addresses/:id" => "addresses#update"
    get "/addresses/:id" => "addresses#destroy"
   end

  
  scope module: :public do
  resources :orders 
    get  "/orders/new" => "orders#new"
    get "/orders/confirm"  => "orders#confirm"
    get "/orders/complete" => "orders#complete"
    get "/orders" => "orders#index"
    get "/orders/:id"  => "orders#show"
    get "orders/create" 
   end

  
  scope module: :public do
  resources :cart_items 
    get "/cart_items" => "cart_items#index" 
    get 'cart_items/update'
    get 'cart_items/destroy'
    get 'cart_items/destroy_all'
    get 'cart_items/create'
   end
  
  scope module: :public do
    resources :customers 
    get "/customers/my_page" => "customers#show"
    get "/customers/information/edit"  => "customers/edit"
    get "/customers/information" => "/customers#update"
    get "/customers/unsubscribe" => "customers#unsubscribe"
    get "/customers/withdraw" => "customers#withdraw"
   end

  
   scope module: :public do
     resources :homes
     root to: 'homes#top'
     get "/about" => "homes#about", as: "about"
   end
  
   scope module: :public do
     resources :items
     get "/items" => "public/items#index", as: "lot"
     get "/items/:id" => "items#show", as: "show"
   end

  
  
  
    # 顧客用
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
end