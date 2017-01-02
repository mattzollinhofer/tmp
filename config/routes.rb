Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root 'welcome#index'
  resource :welcome, only: :index
  resources :courses do
    resources :units, only: [:new, :create]
  end
  resources :units, only: [:show, :edit, :destroy, :update] do
    resources :assignments, only: [:new, :create]
  end
  resources :assignments, only: [:show, :edit, :destroy, :update]

  resources :class_periods, only: [:index, :new, :create, :edit, :show, :update, :destroy] do
    resources :students, only: :destroy, to: 'class_periods#remove_student'

    member do
      get 'manage_students'
      patch 'add_students'
    end
  end

  resources :student_welcome, only: :index
  resources :teacher_welcome, only: :index

  resources :class_assignment, only: :update

  resources :gradebooks, only: :show

  get '/playbooks/student/:student_id/class_period/:class_period_id/unit/:unit_id',
      to: 'playbooks#show', as: :playbook
end
