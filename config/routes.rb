Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'welcome#index'
  resources :welcome, only: :index
  resources :courses, only: [:index, :create, :new, :edit, :update, :destroy]

  resources :student_welcome, only: :index
  resources :teacher_welcome, only: :index

  get '/planning' => 'planning#index', as: 'planning'
end
