Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :trips, only: [:show, :index, :new, :create, :delete] do
    resources :tasks, only: [:new, :create, :edit, :update, :delete ] do
      resources :subtasks, only: [:new, :create, :edit, :update, :delete ]
    end
  end

  # Dashboard
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'form', to: 'pages#form', as: 'form'
  get 'form2', to: 'pages#form2', as: 'form2'

end
