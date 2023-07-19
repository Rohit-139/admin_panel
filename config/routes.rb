Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :instructors, only: [:create, :destroy]
  resources :programs
  get '/filter', to: 'programs#filter_on_status_basis'


  resource :customers, only: [:show, :create, :destroy]
  resources :enrolls
  get '/category_wise', to: 'enrolls#category_wise_courses'

  post '/login', to: 'users#login'

end
