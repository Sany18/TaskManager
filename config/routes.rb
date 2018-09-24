Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :tasks
  root 'tasks#index'
  delete '/task/delete_selected/:id' => 'tasks#destroy_selected'
  get '/task/status_switch/:id' => 'tasks#statusSwitch'
  # '/foo' => '/foo#index'.
end
