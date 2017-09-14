Rails.application.routes.draw do
  resources :tournaments do
    resources :phases, shallow: true, except: [:show]
  end

  root to: 'tournaments#index'
end
