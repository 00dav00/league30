Rails.application.routes.draw do
  resources :tournaments
  root to: 'tournaments#index'
end
