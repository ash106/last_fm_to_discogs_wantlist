Rails.application.routes.draw do
  root 'users#show'
  get 'users/show'
  get 'users/:username', to: 'users#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
