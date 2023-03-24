class Api::AuthController < ApplicationController

  def encode_token(payload)
    JWT.encode(payload, Figaro.env.JWT_SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        decode_jwt_token(token)
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def verify_auth_token(token)
    if token
      token = token.split(' ')
      return if token.length < 2
      token = token[1]
      begin
        decoded_t = decode_jwt_token(token)
      rescue JWT::DecodeError
        return
      end
      user_id = decoded_t[0]['user_id']
      expiry_time = decoded_t[0]['expiry_time']
      expiry_datetime = expiry_time.to_datetime
      p "expiry_datetime: #{expiry_datetime}"
      @user = User.find_by(id: user_id) if expiry_datetime > DateTime.now
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      expiry_time = decoded_token[0]['expiry_time'].to_datetime
      p "expiry_time: #{expiry_time}", "DateTime.now: #{DateTime.now}"
      @user = User.find_by(id: user_id) if expiry_time > DateTime.now
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    raise BaseError::Unauthorized.new("Please Log In") unless logged_in?
  end

  def decode_jwt_token(token)
    JWT.decode(token, Figaro.env.JWT_SECRET, true , algorithm: 'HS256')
  end

end