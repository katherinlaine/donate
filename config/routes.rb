require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  constraints Monban::Constraints::SignedIn.new do
    root "user_dashboards#show", as: :dashboard
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new"
  end

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :food_types, only: [:create, :destroy, :index]
    resources :agencies do
      collection { post :import, to: "agencies#create_from_csv" }
      resources :users, shallow: true
    end
  end

  namespace :agency_admin do
    resources :agencies, only: [:show, :edit, :update]
  end

  resource :search, only: [:show]
  resource :filter, only: [:show]
  resources :agencies, only: [:index, :show]
end
