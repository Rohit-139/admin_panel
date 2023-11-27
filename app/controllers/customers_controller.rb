class CustomersController < ApiController

  skip_before_action :user_authenticate, only: [:create]
  # before_action :authorizeration, only: [:show, :create]
   load_and_authorize_resource except: :create

  def show
    programs = Program.where(status: 'active')
    if programs.empty?
      render json: { message: 'There is no Courses' }
    else
      render json: programs, status: :ok
    end
  end

  # def create
  #   customer = Customer.new(customer_params)
  #   if customer.save
  #     render json: customer, status: :created
  #   else
  #     render json: customer.errors.messages
  #   end
  # end

  def destroy
    # authorize Customer
    if @current_user.destroy
      render json: { message: 'User Destroy Successfully' }
    else
      render json: { message: 'No Record Found' }
    end
  end

  private
  # def authorizeration
  #   authorize Customer
  # end

  # def customer_params
  #   params.permit(:name, :email, :password)
  # end
end
