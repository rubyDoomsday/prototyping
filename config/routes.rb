Rails.application.routes.draw do
  root 'application#raise_not_found!'

  # catch all invalid routes
  match '*unmatched_route', to: 'application#raise_not_found!', via: :all
end
