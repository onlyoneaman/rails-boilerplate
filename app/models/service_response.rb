class ServiceResponse
  attr_reader :status, :data, :errors

  class << self
    def success(data)
      new(status: :ok, data: data)
    end

    def errors(errors)
      new(status: :internal_server_error, errors: errors)
    end

    def un_known_error(errors)
      new(status: :internal_server_error, errors: errors)
    end

    def bad_request_error(errors)
      new(status: :bad_request_error, errors: errors)
    end
  end

  def initialize(status:, data: nil, errors: nil)
    @status = status
    @data = data
    @errors = errors.presence || []
  end

  def success?
    status == :ok
  end

  def body
    {
      success: success?,
      data: data,
      errors: errors,
    }
  end
end
