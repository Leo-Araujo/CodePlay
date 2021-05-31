Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :courses, only: %i[index show new create] do
    resources :lessons, only: %i[new create show edit update destroy]
  end

  resources :instructors, only: %i[index show new create edit update]
end
