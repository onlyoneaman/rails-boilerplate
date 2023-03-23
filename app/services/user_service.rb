class UserService
  class << self

    def create(params)
      record = User.new(params)
      user = User.find_by(email: params[:email])
      return ServiceResponse.errors(["User already exists with email: #{params[:email]}"]) if user.present?
      if record.save
        return ServiceResponse.success(User.to_s.underscore => record.to_hash)
      else
        return ServiceResponse.errors(record.errors.full_message.join(','))
      end

    rescue StandardError => e
      return ServiceResponse.errors([e.message])
    end

    def index
      records = User.all

      ServiceResponse.success(records)
    end
  end
end