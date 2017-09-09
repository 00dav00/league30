Rails.application.routes.draw do
  resources :tournaments do
    resources :phases, shallow: true
  end

  root to: 'tournaments#index'
end
