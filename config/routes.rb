Rails.application.routes.draw do
  resources :organizations
  mount MissionControl::Jobs::Engine, at: "/jobs"
  resources :data_uploads do
    member do
      post "generate_report" => "data_uploads#generate_report"
    end
  end
  resource :session, only: %i[new create destroy]
  resources :passwords, param: :token
  resources :questionnaires do
    resources :responses, only: %i[index show new create destroy]
  end
  resources :curriculums do
    resources :lessons
  end
  resources :sites do
    resources :site_participants, only: :index
    resources :sections do
      resources :section_participants, only: %i[index show] do
        resources :section_participant_responses, only: %i[new create edit update]
      end
      resources :sittings do
        collection do
          get "bulk" => "sittings#bulk"
          post "bulk_create" => "sittings#bulk_create"
        end
        resources :attendances, only: :index
      end
      member do
        post "data_tracker" => "sections#data_tracker"
      end
    end
  end
  resources :participants do
    collection do
      get "bulk" => "participants#bulk"
      post "bulk_create" => "participants#bulk_create"
    end
  end
  resources :users, only: %i[index show new create edit update] do
    member do
      post "invite" => "users#invite"
    end
  end

  scope :active_storage, module: :active_storage, as: :active_storage do
    resources :attachments, only: [ :destroy ]
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
