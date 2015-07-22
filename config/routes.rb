Rails.application.routes.draw do
  root "courses#show"
  get "help"    => "static_pages#help"
  get "about"   => "static_pages#about"
  get "contact" => "static_pages#contact"

  devise_for :users
  resources :users, except: [:index, :create, :new]
  resources :courses, only: :show do
    resources :user_subjects, only: [:show, :update] do
      post "/:status" => "subjects#update", as: :finish_subject
    end
  end
  
  namespace :admin do
    root "dashboards#index"
    resources :users
    resources :subjects
    resources :courses do 
      resources :user_courses, only: :destroy
      resource :assign_trainees, only: [:edit, :update]
      resources :course_subjects, only: [:show, :update] do
        patch "/:active" => "course_subjects#update", as: "active"
      end
    end
  end
end
