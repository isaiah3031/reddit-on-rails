Rails.application.routes.draw do
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  resources :subs, only: %i[index new create edit update show] do
    resources :posts, only: %i[new create]
  end
  resources :posts, only: %i[show edit update]
end
