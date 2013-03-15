Crockue::Application.routes.draw do
  resources :flarks
  root :to => 'flarks#index'
end
