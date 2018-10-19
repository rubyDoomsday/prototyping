Rails.application.routes.draw do
  root 'application#raise_not_found!'

  # Deivces and Sources Prototyping
  resources :sources, param: :id, only: %i[index show]

  # catch all invalid routes
  match '*unmatched_route', to: 'application#raise_not_found!', via: :all
end
