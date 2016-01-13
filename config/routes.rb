Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'

  root 'root#home'

  get 'search', to: 'root#home'
  post 'search', to: 'root#search'
end
