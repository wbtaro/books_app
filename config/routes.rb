# frozen_string_literal: true

Rails.application.routes.draw do
  resources :comments
  devise_for :users, path: "/account", controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  scope "(/:locale)" do
    resources :books
    resources :booklists, only: [:index, :show]
    resources :followers, only: [:index]
    resources :follows, only: [:index, :destroy, :create]
    resources :reports
    resources :reportlists, only: [:index, :show]
    resources :users, only: [:index, :show]
  end
  root "books#index"
end
