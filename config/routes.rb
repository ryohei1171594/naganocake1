Rails.application.routes.draw do
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  items: 'public/items'
}
  
  devise_for :admin, controllers: {
  sessions: "admin/sessions",
  items: 'admin/items'
}
namespace :public do
    get 'homes/top'
    get 'homes/about'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers
    get'customers/mypage', :to =>'customers#show'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    root to: 'home#top'
    get 'orders/complete' => 'orders#complete'
    post 'orders/confirm' => 'orders#confirm'
    resources :orders
  end
  namespace :admin do
    get 'homes/top'
    get 'homes/about'
    resources :items
    resources :customers
    resources :orders
    resources :order_details
    resources :order_items
  end
   
end
