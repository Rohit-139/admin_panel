class InstructorsController < ApplicationController
  skip_before_action :instructor_authenticate_request, only: [:create, :login]
  skip_before_action :customer_authenticate_request
  def index
    # @programs = fitne
  end

  def show
  end

  def create
    @instructor = Instructor.new(instruct_params)

    if @instructor.save
      render json: @instructor ,status: :ok
    else
      render json: {error: "registraton failed"}
    end
  end



  def login
    # byebugS
    @instructor= User.find_by(email: params[:email], password: params[:password])
    if @instructor
      if @instructor.type == 'Instructor'
        token = jwt_encode(user_id: @instructor.id)
        render json: {token: token}, status: :ok
      else
        render json: {error: 'Please login with instructor credentials'}
      end
    else
      render json: {error: 'login failed'}
    end
  end

  private
    def instruct_params
      params.permit(:name, :email, :password)
    end
end
