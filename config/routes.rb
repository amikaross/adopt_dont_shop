Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  get '/shelters/:id', to: 'shelters#show'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/veterinary_offices', to: 'veterinary_offices#index'
  get '/veterinary_offices/new', to: 'veterinary_offices#new'
  get '/veterinary_offices/:id', to: 'veterinary_offices#show'
  post '/veterinary_offices', to: 'veterinary_offices#create'
  get '/veterinary_offices/:id/edit', to: 'veterinary_offices#edit'
  patch '/veterinary_offices/:id', to: 'veterinary_offices#update'
  delete '/veterinary_offices/:id', to: 'veterinary_offices#destroy'

  get '/veterinarians', to: 'veterinarians#index'
  get '/veterinarians/:id', to: 'veterinarians#show'
  get '/veterinarians/:id/edit', to: 'veterinarians#edit'
  patch '/veterinarians/:id', to: 'veterinarians#update'
  delete '/veterinarians/:id', to: 'veterinarians#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelters#pets'
  get '/shelters/:shelter_id/pets/new', to: 'pets#new'
  post '/shelters/:shelter_id/pets', to: 'pets#create'

  get '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinary_offices#veterinarians'
  get '/veterinary_offices/:veterinary_office_id/veterinarians/new', to: 'veterinarians#new'
  post '/veterinary_offices/:veterinary_office_id/veterinarians', to: 'veterinarians#create'

  get '/adopt_apps/new', to: 'adopt_apps#new'
  post'/adopt_apps/new', to: 'adopt_apps#create'
  get '/adopt_apps/:id', to: 'adopt_apps#show'
  patch '/adopt_apps/:id', to: 'adopt_apps#update'

  get '/admin/shelters', to: 'admin_shelters#index'
  get '/admin/adopt_apps/:id', to: 'admin_adopt_apps#show'
  patch '/admin/adopt_apps/:id', to: 'admin_adopt_apps#update'

end
