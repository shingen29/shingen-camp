Rails.application.routes.draw do
  root 'static_pages#home'
  get 'stripe' => 'static_pages#stripe'
  post 'checkout' => 'static_pages#checkout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
