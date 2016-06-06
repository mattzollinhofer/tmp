Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'welcome#index'
  resources :courses

  resources :student_welcome, only: :index
  resources :teacher_welcome, only: :index
  get 'welcome', to: 'student_welcome#index'
end
