Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :instructors, only: [:create, :destroy]
  resources :programs
  resource :customers, only: [:show, :create, :destroy]
  resources :enrolls
  resource :users#, only: [:create,:destroy]

  get '/filter', to: 'programs#filter_on_status_basis'
  get '/category_wise', to: 'enrolls#category_wise_courses'
  post '/login', to: 'users#login'

end
