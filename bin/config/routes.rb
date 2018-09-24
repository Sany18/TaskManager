Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :task
  root 'task#index'
  delete '/task/delete_selected/:id' => 'task#destroy_selected'
  get '/task/status_switch/:id' => 'task#statusSwitch'
  # '/foo' => '/foo#index'.
end
