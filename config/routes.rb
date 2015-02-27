Rails.application.routes.draw do
  root "home#show"

  resource :session
  resources :presenters
  resources :videos
  resources :suggestions
  resources :users

  resource :profile, :controller => :users, :only => %i(edit update)

  get "/auth/:provider/callback", :to => "sessions#create"
end
