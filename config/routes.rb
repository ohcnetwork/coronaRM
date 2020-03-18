Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'contacts#index'
  devise_for :users, :controllers => { :registrations => 'registrations'}

  resources :contacts, except: [:destroy] do
    get :make_call, on: :member
    get :make_related_call, on: :member
    resources :non_medical_reqs do
      get :fullfill, on: :member
    end
    resources :medical_reqs do
      get :fullfill, on: :member
    end
    resources :previous_medical_conditions do
    end
    resources :symptoms do
    end
  end
end
