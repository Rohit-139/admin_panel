class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :instructor_authenticate_request
  before_action :customer_authenticate_request

  private
    def instructor_authenticate_request
      byebug
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_instructor = User.find(decoded[:user_id])

    end

    def customer_authenticate_request

      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_customer = User.find(decoded[:user_id])
    end
end
