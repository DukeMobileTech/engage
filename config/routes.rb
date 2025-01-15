Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :passwords, param: :token
  resources :questionnaires do
    resources :responses, only: %i[index show new create]
  end
  resources :curriculums do
    resources :lessons
  end
  resources :sites do
    resources :site_participants, only: :index
    resources :sections do
      resources :section_participants
      resources :sittings do
        resources :attendances, only: :index
      end
    end
  end
  resources :participants

  namespace :turbo, defaults: { format: :turbo_stream } do
    resources :sections, only: :index
    resources :sittings, only: :index
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "sites#index"
end
