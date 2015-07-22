Rails.application.routes.draw do
  root "static_pages#home"
  get "help"    => "static_pages#help"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  devise_for :users
  resources :users, except: [:index, :create, :new]

  namespace :admin do
    root "dashboards#index"
    resources :users
    resources :subjects
    resources :courses do 
      resources :user_courses, only: :destroy
    end
  end
end
