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
    resources :booklists, only: [:index, :show]
    resources :followers, only: [:index]
    resources :follows, only: [:index, :destroy, :create]
    resources :reports
    resources :reportlists, only: [:show]
    resources :users, only: [:index, :show]
  end
  root "books#index"
end
