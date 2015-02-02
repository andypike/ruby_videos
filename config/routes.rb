Rails.application.routes.draw do
  root "home#show"

  resource :session
  resources :presenters

  get "/auth/:provider/callback", :to => "sessions#create"
end
