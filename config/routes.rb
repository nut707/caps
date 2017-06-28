Rails.application.routes.draw do
  devise_for :users
  # root 'home#index'
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  get 'home/index' => 'home#index', as: :home
  get 'users'=>'users#index'

  resources :profiles do
    resources :stays
  end

  resources :publications do
    member do
      get :add_author
      post 'add_author' => 'publications#add_author_update'
    end

    collection do
      get 'my' => 'publications#my'
      post :add_profile
      get :autocomplete_profile_last_name 
    end
    resources :external_authors
  end

  delete 'publications/:publication_id/author_remove/:id' => 'publications#author_remove', as: :author_remove_publication

  resources :projects do
    get 'my' => 'projects#my', on: :collection
    member do
      patch 'change_status' => 'projects#change_status'
      patch 'draft' => 'projects#change_status', status: '0'
      patch 'confirming' => 'projects#change_status', status: '1'
      patch 'confirmed' => 'projects#change_status', status: '2'
      patch 'archive' => 'projects#change_status', status: '3'
      put 'add_publication' => 'projects#add_publication', as: :add_publication
      delete 'remove_publication' => 'projects#remove_publication', as: :remove_publication
    end
    resources :participants do 
      get :autocomplete_profile_last_name, on: :collection 
    end
    resources :events do
      patch :add_report, on: :member
    end
    resources :researches
    resources :other_events
    resources :edu_programs do
      resources :students
    end
    resources :courses do
      resources :teachers
    end

    resources :expense_periods, shallow: true
    resources :planned_expenses
    resources :reserve_docs
    resources :expense_docs do
      get 'reserve_docs_list', as: :reserve_docs_list, on: :collection
    end
  end
  get 'participants/role_fields_form' => 'participants#role_fields_form', as: :role_fields_form

  resources :roles do
    resources :role_fields do
      resources :role_fields_values
    end
  end

  resources :science_branches
  resources :activity_directions
  resources :rates
  resources :languages
  resources :nationalities

  resources :expense_items
end
