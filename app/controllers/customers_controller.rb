class CustomersController < ApplicationController
  skip_before_action :customer_authenticate_request, only: [:create, :login]
  skip_before_action :instructor_authenticate_request


  def index
    program = Program.where(status: 'active')
    return render json: { message: 'There is no Cources' } if program.empty?

    render json: program
  end

  def show
  end

  def enroll_program
    program = Program.find_by(name: params[:name])
    return render json: { message: 'Course is not active to enroll' } unless program.status == 'active'

    enroll = @current_customer.enrolls.new(name: program.name, level: 'started', program_id: program.id)

    return render json:  enroll.errors.messages unless enroll.save

    render json: { message: 'You have successfully enrolled' }
  rescue NoMethodError => e
    render json: e.message
  end

  def list_enroll_programs
    @enrolls = @current_customer.enrolls.all
    return render json: { message: 'You are not enrolled in any program' } if @enrolls.empty?

    render json: @enrolls
  end

  def search_category_wise
    program = Program.where(category_id: Category.where("name LIKE '%#{params[:name].strip}'").pluck(:id))
    return render json: program unless program.empty?

    render json: { message: 'No Courses Found in this category' }
  end

  def update_enroll_status
    enroll = Enroll.find(params[:id])
    status = @current_customer.enrolls.update(level: 'finished')
    return render json: 'Successfully Marked as Finished' if status
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  def create
    @customer = Customer.new(customer_params)
    return render json: @customer if @customer.save

    render json: @customer.errors.messages
  end

  def login
    @customer = User.find_by(email: params[:email], password: params[:password])
    return render json: { error: 'Invalid email and password' } unless @customer
    return render json: { error: 'Please login with instructor credentials' } unless @customer.type == 'Customer'

    token = jwt_encode(user_id: @customer.id)
    render json: { token: token, message: "#{@customer.name} logged in Successfully" }
  end

  private

  def customer_params
    params.permit(:name, :email, :password)
  end
end
