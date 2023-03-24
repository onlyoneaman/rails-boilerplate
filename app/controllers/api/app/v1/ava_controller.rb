module Api
  module App
    module V1
      class AvaController < Api::AuthController
        before_action :authorized

        def me
          render json: success_response(@user)
        end

      end
    end
  end
end