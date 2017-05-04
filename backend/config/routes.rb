Rails.application.routes.draw do
  post '/token', to: 'tokens#create'
  resources :toys, only: [:index]
end
