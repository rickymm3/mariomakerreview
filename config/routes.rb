BaseApp::Application.routes.draw do

  resources :cliqs do
    resources :topics do
      resources :replies
    end
    member do
      get :admin
    end
  end

  resources :favorites, only: [:update]

  resources :topic_report do
    member do
      post :report
      get :report_ajax
    end
  end

  root :to => "cliqs#index"

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'users/registrations' }

  get "pages/index"
  get "/admin" => "admin/base#index", :as => "admin"
  namespace "admin" do
    resources :users
    resources :reports
  end
  resources :users, only: [:show]

  get "pages/not_authorized"

end
