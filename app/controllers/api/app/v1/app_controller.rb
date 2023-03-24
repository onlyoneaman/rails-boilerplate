module Api
  module App
    module V1
      class AppController < ::ApplicationController

        def login
          render json: success_response(AppService::V1::AppService.login(login_permitted_params))
        end

        def register
          render json: success_response(AppService::V1::AppService.register(register_permitted_params))
        end

        private

        def login_permitted_params
          params.require(:email)
          params.require(:password)
          params.require(:app).permit!
        end

        def register_permitted_params
          params.require(:name)
          params.require(:email)
          params.require(:password)
          params.require(:app).permit!
        end

      end
    end
  end
end