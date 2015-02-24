Rails.application.routes.draw do
  root "home#show"

  resource :session
  resources :presenters
  resources :videos
  resources :suggestions

  get "/auth/:provider/callback", :to => "sessions#create"
end
