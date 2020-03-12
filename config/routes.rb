Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'share', to: 'pages#share', as: 'share'
  post 'share_ref', to: 'pages#share_ref', as: 'share_ref'

  resources :trips do
    resources :tasks, only: [:new, :create]
  end
  resources :tasks, only: [:edit, :update, :destroy] do
    resources :subtasks, only: [:new, :create]
  end

  get 'loading', to: 'trips#loading', as: 'loading'
  get 'confirmation', to: 'trips#confirmation', as: 'confirmation'

  resources :feedbacks, only: [:new, :create]
  resources :subtasks, only: [:edit, :update, :destroy]

  post 'auto_create', to: 'trips#auto_create', as: 'auto_create'
  get 'background_create', to: 'trips#background_create', as: 'background_create'

  get 'form', to: 'pages#form', as: 'form'
  get 'form2', to: 'pages#form2', as: 'form2'

  # get '*path' => redirect('/')

  resources :chat_rooms, only: [ :show ] do
    resources :messages, only: [ :create ]
  end
  mount ActionCable.server => "/cable"
end
