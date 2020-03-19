# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(/:locale)" do
    resources :books
    resources :users, only: [:index, :show]
    devise_for :users, path: "/account"
  end
  root "books#index"
end
