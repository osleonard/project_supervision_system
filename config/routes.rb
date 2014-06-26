ProjectSupervisionSystem::Application.routes.draw do
  resources :users do
    resources :projects
    match '/upload', to:'projects#new', via: 'get'
    match '/download', to: 'projects#show', via: 'get'
    match 'edit', to: 'project#edit', via: 'get'
  end
  resources :sessions, only: [:new, :create, :destroy]
  root  'static_pages#home'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/register', to: 'static_pages#register', via: 'get'
  match '/signup', to:'users#new', via: 'get'
  match '/signin', to:'sessions#new', via:'get'
  match '/signout', to:'sessions#destroy', via:'delete'  
end
