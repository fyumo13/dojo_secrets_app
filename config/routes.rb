Rails.application.routes.draw do
  resources :users, :sessions, :secrets, :likes
end
