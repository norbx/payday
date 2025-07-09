Rails.application.routes.draw do
  resources :expenses_imports, only: [ :index, :create ], path: :imports, as: :imports, controller: :imports
  resource :categorise, only: [ :show, :create ], controller: :categorise

  root "categorise#show"

  get "up" => "rails/health#show", as: :rails_health_check
end
