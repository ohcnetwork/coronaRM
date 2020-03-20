Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'dashboard#index'
  devise_for :users, :controllers => { :registrations => 'registrations'}

  resources :dashboard, only: [:index] do
    get :csv_report, on: :collection
    get :called_report_today, on: :collection
    get :contacts_contacted, on: :collection
    get :not_reachable_report_today, on: :collection
    get :report_travellers, on: :collection
    get :medical_needs_report_today, on: :collection
    get :non_medical_needs_report_today, on: :collection
    get :health_care_workers, on: :collection
    get :generate_symptomatic, on: :collection
    get :generate_symptomatic_today, on: :collection
  end

  resources :contacts, except: [:destroy] do
    get :make_call, on: :member
    get :call_not_reachable, on: :member
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
    resources :flight_details do
    end
  end
end
