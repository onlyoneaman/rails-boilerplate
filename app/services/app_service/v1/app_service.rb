module AppService
  module V1
    class AppService::V1::AppService

      class << self

        def login(params)
          user = User.find_by(email: params[:email])
          if user && user.password == params[:password]
            token = encode_token(
              {
                user_id: user.id,
                expiry_time: DateTime.now + Figaro.env.EXPIRY_HOURS.to_i.hours
              }
            )
            token
          else
            nil
          end
        end

        def register(params)
          UserService.create(params)
        end

        private

        def encode_token(payload)
          JWT.encode(payload, Figaro.env.JWT_SECRET)
        end

      end

    end
  end
end