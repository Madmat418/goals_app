GoalApp::Application.routes.draw do
  resources :users, :only => [:create, :new, :index, :show]
  resources :goals, :only => [:index, :update, :create]
  resource :session, :only => [:create, :new, :destroy]
end
