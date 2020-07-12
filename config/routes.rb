Rails.application.routes.draw do
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
end
