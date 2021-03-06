Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home', as: 'home'

  resource :profiles, only: %i[edit update show]

  resources :containers, except: %i[index show destroy] do
    resources :cards, except: %i[index destroy] do
      resources :tags, only: %i[new create]
    end
  end

  resources :containers, only: :destroy
  resources :cards, only: :destroy
  resources :tags, only: %i[destroy edit update]

  resources :schedules, only: %i[index create update destroy]

  resources :pomodoros, only: %i[index]

  get "dashboard", to: "pages#dashboard", as: "dashboard"
  get "about", to: "pages#about", as: "about"
  get "plan", to: "pages#plan", as: "plan"
  get "profile", to: "pages#profile", as: "profile"

  patch "update_cards", to: "pages#update_cards", as: "update_cards"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
