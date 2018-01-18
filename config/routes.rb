Rails.application.routes.draw do
  resources :theatres
  resources :movies
  resources :auditoria
  resources :viewers
  resources :showtimes
  resources :bookings
  resources :tickets
  resources :seats
end