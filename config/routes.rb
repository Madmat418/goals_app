GoalApp::Application.routes.draw do
  resources :users, :only => [:create, :new]
  resources :goals, :only => [:index]
  resource :session, :only => [:create, :new, :destroy]
end
