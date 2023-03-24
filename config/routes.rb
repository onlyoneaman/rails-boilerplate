Rails.application.routes.draw do

  get '/ping', to: 'ping#ping'

  namespace :api do
    namespace :v1 do

      resources :users, only: %i[create index]

    end

    namespace :app do
      namespace :v1 do

        post '/login', to: 'app#login'
        post '/register', to: 'app#register'
        get '/me', to: 'ava#me'

      end

    end

  end

  match '*any', to: 'not_found#anything', via: [:get, :post]

end
