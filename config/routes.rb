Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :trips, only: [:show, :index, :new, :create, :destroy] do
    resources :tasks, only: [:new, :create] do
      resources :subtasks, only: [:new, :create]
    end
  end
  resources :tasks, only: [:edit, :update, :destroy]
  resources :subtasks, only: [:edit, :update, :destroy]

  get 'form', to: 'pages#form', as: 'form'
  get 'form2', to: 'pages#form2', as: 'form2'

end
