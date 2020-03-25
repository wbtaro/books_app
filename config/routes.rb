# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: "/account", controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  scope "(/:locale)" do
    resources :books
    resources :users, only: [:index, :show]
    resources :follows, only: [:index, :destroy, :create]
    resources :booklists, only: [:show]
    resources :followers, only: [:index]
  end
  root "books#index"
end
