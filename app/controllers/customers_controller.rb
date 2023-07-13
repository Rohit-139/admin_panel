class CustomersController < ApplicationController
  skip_before_action :customer_authenticate_request, only: [:create, :login]
  skip_before_action :instructor_authenticate_request


  def index
    programs = Program.where(status: 'active')
    if programs.empty?
      render json: { message: 'There is no Courses' }
    else
      render json: programs, status: :ok
    end
  end

  def show
    enroll = @current_customer.enrolls.find_by(id: params[:id])
    if enroll.present?
      render json: enroll, status: :ok
    else
      render json: { message: 'You are not enrolled in this course'}
    end
  end

  def enroll_program
    program = Program.find_by(name: params[:name])
    if program.present?
      if program.status == 'active'
        enroll = @current_customer.enrolls.new(name: program.name, level: 'started', program_id: program.id)
        if  enroll.save
          render json: { message: 'You have successfully enrolled' }, status: :created
        else
          render json:  enroll.errors.messages
        end
      else
        render json: { message: 'Course is not active to enroll' }, status: :unprocessable_entity
      end
    else
      render json: { message: 'No Course found with this name' }
    end
  end

  def list_enroll_programs
    enrolls = @current_customer.enrolls
    if enrolls.present?
      render json: @enrolls, status: :ok
    else
      render json: { message: 'You are not enrolled in any program' }
    end
  end

  # def search_category_wise_and_name
  #   program = Program.where(category_id: Category.where(" name LIKE '%#{params[:catname]}' ").pluck(:id)) .or (Program.where("name LIKE '%#{params[:name]}'"))
  #   return render json: program unless program.empty?

  #   render json: { message: 'No Courses Found in this category' }
  # end

  def update_enroll_status
    enroll = @current_customer.enrolls.find_by(id:params[:id])
    if enroll.level == params[:status]
      render json: { message: "Program has already #{params[:status]} status" }
    else
      @current_customer.enrolls.update(level: 'finished')
      render json: 'Successfully Marked as Finished', status: :ok
    end
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer, status: :created
    else
      render json: @customer.errors.messages
    end
  end

  def login
    @customer = User.find_by(email: params[:email], password: params[:password])
    if customer.present?
      if @customer.type == 'Customer'
        token = jwt_encode(user_id: @customer.id)
        render json: { token: token, message: "#{@customer.name} logged in Successfully" }, status: :ok
      else
        render json: { error: 'Please login with instructor credentials' }
      end
    else
      render json: { error: 'Invalid email and password' }
    end
  end

  private

  def customer_params
    params.permit(:name, :email, :password)
  end
end
