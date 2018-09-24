Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'user/registrations' }
  resources :ttts
  root 'ttts#index'
  delete '/ttts/delete_selected/:id' => 'ttts#destroy_selected'
  get '/ttts/status_switch/:id' => 'ttts#statusSwitch'
  # '/foo' => '/foo#index'.
end
