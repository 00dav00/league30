Rails.application.routes.draw do
  resources :teams, except: [:show]
  resources :tournaments do
    resources :phases, shallow: true, except: [:show]
    resources :contestants
  end

  root to: 'tournaments#index'
end
