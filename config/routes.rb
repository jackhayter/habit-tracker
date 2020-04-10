# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'trackers#index'
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create destroy]
  resources :trackers do
    resources :grades
    resources :entries
  end
end
