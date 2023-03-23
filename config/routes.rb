Rails.application.routes.draw do

  get '/ping', to: 'ping#ping'

  namespace :api do
    namespace :v1 do

      resources :users, only: %i[create index]

    end
  end

end
