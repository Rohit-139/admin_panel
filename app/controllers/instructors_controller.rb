class InstructorsController < ApplicationController
  skip_before_action :instructor_authenticate_request, only: [:create, :login]
  skip_before_action :customer_authenticate_request
  def index
    @programs = @current_instructor.programs.all
    if @programs
      listing(@programs)
    else
      render json: {error: 'record not found'}
    end
  end

  def show
    @program = @current_instructor.programs.find(params[:id])
    if @program
      arr = Array.new
      h = Hash.new
      h[:name] = @program.name
      h[:status] = @program.status
      h[:video] = @program.video.url
      arr << h
      render json: arr
    end
    rescue
      render json: {error: 'Record not found'}
  end

  def create
    @instructor = Instructor.new(instruct_params)

    if @instructor.save
      render json: @instructor ,status: :ok
    else
      render json: @instructor.errors.messages
    end
  end

  def create_program
    @program=@current_instructor.programs.new(program_params)
    @program.video.attach(params[:video])
    if @program.save
      render json: {message: @program.video.url}
    else
      render json: {error: @program.errors.messages}
    end
  end

  def search
    @program = @current_instructor.programs.where("name LIKE '%#{params[:name]}%'").or(@current_instructor.programs.where(status: params[:status]))
    if @program.empty?
      render json: {error: 'Record not found'}
    else
      listing(@program)
    end
  end

  def update
    @program = @current_instructor.programs.find(params[:id])
    if @program
      @program.update(status: params[:status])
      render json: {message: 'Status Updated Successfully'}
    end
    rescue
      render json: {message: 'Record not found'}
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
      render json: {error: 'Invalid email and password'}
    end
  end

  def destroy
    # byebug
    @program = @current_instructor.programs.find(params[:id])
    if @program
      @program.destroy
      render json: {message: "Program deleted Successfully"}
    end
    rescue
      render json: {message: 'record not found'}
  end

  def listing(program)
    arr = Array.new
    program.each do |i|
      h = Hash.new
      h[:name] = i.name
      h[:status] = i.status
      h[:video] = i.video.url
      arr.push(h)
    end
    render json: arr
  end

  private
    def instruct_params
      params.permit(:name, :email, :password)
    end

    def program_params
      params.permit(:name, :category_id, :status, :video)
    end
end
