class CustomersController < ApplicationController
  def index
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer ,status: :ok
    else
      render json: {error: "registraton failed"}
    end
  end

  def login
    @customer = User.find_by(email:params[:email], password:params[:password])
    if @customer
      if @customer.type == 'customer'
        token = jwt_encode(id: @customer.id)
        render json: {token: token}, status: :ok
      else
        render json: {error: 'Please login with customer credentials'}
    else
      render json: {error: 'login failed'}
    end
  end

  private
    def customer_params
      params.permit(:name, :email, :password)
end
