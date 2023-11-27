class UsersController < ApiController

  skip_before_action :user_authenticate

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
      WelcomeMailer.mailer(user).deliver_now!
    else
       render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user.present?
      token = jwt_encode(user_id: user.id)
      render json: { token: token, message: "#{user.name} logged in Successfully" }, status: :ok
    else
      render json: { error: 'Invalid email and password' }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :country_name, :state, :city, :user_type )
  end
end
