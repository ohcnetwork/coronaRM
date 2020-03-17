Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'contacts#index'
  devise_for :users

  resources :contacts, except: [:destroy] do
    resources :non_medical_reqs do
      get :fullfill, on: :member
    end
  end
end
