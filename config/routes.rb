Rails.application.routes.draw do
  resources :phases
  resources :tournaments
  root to: 'tournaments#index'
end
