class UsersController < ApiController
  skip_before_action :user_authenticate
  skip_before_action :instructor_check
  skip_before_action :customer_check

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user.present?
      token = jwt_encode(user_id: user.id)
      render json: { token: token, message: "#{user.name} logged in Successfully" }, status: :ok
    else
      render json: { error: 'Invalid email and password' }
    end
  end
end
