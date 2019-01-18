# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root 'administration/items#index'

  get '/home', to: 'home#landing_page'

  namespace 'administration' do
    get '/', to: 'items#index'

    resources :items
    resources :profiles do
      member do
        get '/send_email', to: "profiles#send_email", as: :send_email
      end
    end
  end
end
