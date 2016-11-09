Rails.application.routes.draw do
  get 'exams/index'

  get 'exams/show'

  namespace :admin do
    resources :categories, except: :show
    resources :courses, except: :show
    resources :lessons do
      resources :words, except: [:new, :show]
      resources :questions, except: [:new, :show]
    end
  end

  root "static_pages#home"
  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :courses
  resources :lessons
  resources :words
  resources :exams
  resources :results
  get "/create_exam",to: "exams#create_exam"
end
