class InstructorsController < ApplicationController
  skip_before_action :instructor_authenticate_request, only: [:login]
  skip_before_action :customer_authenticate_request

  def index
    programs = @current_instructor.programs
    if programs.present?
      render json: programs, status: :ok
    else
      render json: { error: 'record not found' }, status: :not_found
    end
  end

  def show
    program = @current_instructor.programs.find_by(id: params[:id])
    if program.present?
      render json: @program, status: :ok
    else
      render json: {message: 'Record not found'}, status: :not_found
    end
  end

  def create
    instructor = Instructor.new(instruct_params)
    if instructor.save
      render json: instructor, status: :created
    else
       render json: instructor.errors.messages, status: :unprocessable_entity
    end
  end

  def create_program
    program = @current_instructor.programs.new(program_params)
    if program.save
      render json: program, status: :created
    else
      render json: { error: program.errors.messages }, status: :unprocessable_entity
    end
  end

  # def search
  #   if (params[:name] || params[:status].present?)
  #     if params[:name]
  #       @program = @current_instructor.programs.where("name LIKE '%#{params[:name].strip}%'")
  #       if @program.empty?
  #         render json: { error: 'Record not found' }
  #       else
  #         render json: @program
  #       end
  #     elsif params[:status]
  #       # byebug
  #       @program = @current_instructor.programs.where(status: params[:status].strip)
  #       if @program.empty?
  #         render json: { error: 'Record not found' }
  #       else
  #         render json: @program
  #       end
  #     end
  #   else
  #     render json: { message: 'Please provide required field' }
  #   end
  # end

  def update
    program = @current_instructor.programs.find_by(id:params[:id])
    if program.status == params[:status]
      render json: { message: "Program has already #{params[:status]} status" }
    else
      program.update(status: params[:status])
      render json: { message: 'Status Updated Successfully' }, status: :ok
    end
  end

  def login
    instructor = User.find_by(email: params[:email], password: params[:password])
    if instructor.present?
      if instructor.type == 'Instructor'
        token = jwt_encode(user_id: instructor.id)
        render json: { token: token, message: "#{instructor.name} logged in Successfully:" }, status: :ok
      else
        render json: { error: 'Invalid email and password' }
      end
    else
      render json: { error: 'Please login with instructor credentials' }
    end
  end

  def destroy
    program = @current_instructor.programs.find_by(id:params[:id])
    if program.present?
      program.destroy
      render json: { message: 'Program deleted Successfully' }, status: :ok
    else
      render json: { message: 'No Record Found'}, status: :not_found
    end
  end

  private

  def instruct_params
    params.permit(:name, :email, :password)
  end

  def program_params
    params.permit(:name, :category_id, :status, :video)
  end
end
