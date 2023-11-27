class ApiController < ActionController::API

    include JsonWebToken
    # include Pundit::Authorization

    before_action :user_authenticate

    # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from CanCan::AccessDenied do |exp|
        render json: {message: exp}
    end

    rescue_from ActiveRecord::RecordNotFound do |exp|
        render json: {message: exp}
    end

    private

    def current_user
        @current_user
    end

    def user_authenticate
        header = request.headers["Authorization"]
        header = header.split(" ").last if header
        decoded = jwt_decode(header)
        @current_user = User.find(decoded[:user_id])
    rescue
        render json: {message:"Token Invalid"}
    end

    before_action do
        ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
    end
  
    # def user_not_authorized
    #     render json: {error: "You are not athorized"}
    # end
end
