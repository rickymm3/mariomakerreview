BaseApp::Application.routes.draw do

  resources :cliqs do
    resources :topics
  end

  resources :topics do
    resources :replies
  end

  root :to => "cliqs#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "pages/index"
  get "/admin" => "admin/base#index", :as => "admin"
  namespace "admin" do
    resources :users
  end

  get "pages/not_authorized"

end
