module Api
  module V1
    class UsersController < ::ApplicationController
      def create
        render_response(UserService.create(permitted_params))
      end

      def index
        render_response(UserService.index)
      end

      private

      def permitted_params
        params.require(:name)
        params.require(:email)
        params.require(:password)
        params.require(:user).permit!
      end
    end
  end

end