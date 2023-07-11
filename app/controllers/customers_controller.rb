class CustomersController < ApplicationController
  skip_before_action :customer_authenticate_request, only: [:create, :login]
  skip_before_action :instructor_authenticate_request


  def index
    program = Program.where(status: 'active')
    if program.empty?
      render json: {message: 'There is no Cources'}
    else
      listing(program)
    end
  end

  # collection & member routes
  # Active Admin
  # can can can

  def show
  end

  def enroll_program

    # program = Program.where(" id = '#{params[:id]}' || name = '#{params[:name]}' ")

    # byebug
    program = Program.find_by(name: params[:name])
    if program
      enroll = @current_customer.enrolls.new(name: program.name, level: 'started',program_id: program.id)

      if enroll.save
        render json: {message: "You have successfully enrolled"}
      else
        render json:  enroll.errors.messages
      end
    else
      render json: {message: 'Program not found'}
    end
  end

  def search_category_wise

    program = Program.where(category_id: Category.where("name LIKE '%#{params[:name].strip}'").pluck(:id))
    if program.empty?
      render json: {message: 'No Courses Found in this category'}
    else
      listing(program)
    end
  end

  def list_enroll_programs

    @enrolls = @current_customer.enrolls.all
    if !@enrolls.empty?
      arr = Array.new
      @enrolls.each do |i|
        h = Hash.new
        h[:name] = i.name
        h[:status] = i.level
        arr << h
      end
      render json: arr
    else
      render json:{message: "You are not enrolled in any program"}
    end
  end

  def update_enroll_status
    enroll = Enroll.find(params[:id])
    status = @current_customer.enrolls.update(level: 'finished')
    if status
      render json: "Successfully Marked as Finished"
    end
    rescue
      render json: "Updation failed !!!"
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer ,status: :ok
    else
      render json: @customer.errors.messages
    end
  end

  def login
    @customer = User.find_by(email:params[:email], password:params[:password])
    if @customer
      if @customer.type == 'Customer'
        token = jwt_encode(user_id: @customer.id)
        render json: {token: token}, status: :ok
      else
        render json: {error: 'Please login with customer credentials'}
      end
    else
      render json: {error: 'Invalid email and password'}
    end
  end

  def listing(program)
    arr = Array.new
    program.each do |i|
      h = Hash.new
      h[:name] = i.name
      h[:status] = i.status
      h[:video] = i.video.url
      arr << h
    end
    render json: arr
  end

  private
    def customer_params
      params.permit(:name, :email, :password)
    end
end
