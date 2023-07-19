class ApiController < ActionController::API
    include JsonWebToken

    before_action :user_authenticate
    before_action :instructor_check
    before_action :customer_check

    private

    def user_authenticate
        # byebug
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @current_user = User.find(decoded[:user_id])

        rescue
        render json: {message:"Token Invalid"}
    end

    def instructor_check
        render json: {message:'You are not instructor'} unless @current_user.type == 'Instructor'
    end

    def customer_check
        render json: {message:'You are not customer'} unless @current_user.type == 'Customer'
    end

    before_action do
        ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
    end
  
end
