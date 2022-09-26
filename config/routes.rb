Rails.application.routes.draw do
  resources :styles
  resources :memberships do
    post 'toggle_confirmed', on: :member
  end
  resources :beer_clubs
  resources :users do
    post 'toggle_status', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  get 'signout', to: 'sessions#destroy'

  resources :places, only: [:index, :show]
  post 'places', to:'places#search'

  root 'breweries#index'

  get 'beerlist', to: 'beers#list'

  get 'brewerylist', to: 'breweries#list'
end