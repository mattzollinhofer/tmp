Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'welcome#index'
  resources :welcome, only: :index
  resources :courses do
    resources :units, only: [:new, :create]
  end
  resources :units, only: [:show, :edit, :destroy, :update] do
    resources :assignments, only: [:new, :create]
  end
  resources :assignments, only: [:show, :edit, :destroy, :update]

  resources :class_periods, only: [:index, :new, :create, :edit, :show, :update, :destroy]
  resources :student_welcome, only: :index
  resources :teacher_welcome, only: :index

  get '/planning' => 'planning#index', as: 'planning'
end
