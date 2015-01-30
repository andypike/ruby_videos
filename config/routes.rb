Rails.application.routes.draw do
  root "home#show"

  resource :session

  get "/auth/:provider/callback", :to => "sessions#create"
end
