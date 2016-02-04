Rails.application.routes.draw do
  devise_for :users, :controllers => { registration: 'registrations' }
  resources :posts
  root 'posts#new'
end
