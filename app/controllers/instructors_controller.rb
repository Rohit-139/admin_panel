class InstructorsController < ApplicationController
  skip_before_action :instructor_authenticate_request, only: [:create, :login]
  skip_before_action :customer_authenticate_request

  def index
    program = @current_instructor.programs.all
    return render json: program unless program.empty?

    render json: { error: 'record not found' }
  end

  def show
    @program = @current_instructor.programs.find(params[:id])
    return render json: @program if @program
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  def create
    @instructor = Instructor.new(instruct_params)
    return render json: @instructor if @instructor.save
    return render json: @instructor.errors.messages unless @instructor.save
  end

  def create_program
    @program = @current_instructor.programs.new(program_params)
    @program.video.attach(params[:video])
    return render json: @program if @program.save

    render json: { error: @program.errors.messages }
  end

  def search
    if (params[:name] || params[:status]) && (!params[:name].blank? || !params[:status].blank?)
      if params[:name]
        @program = @current_instructor.programs.where("name LIKE '%#{params[:name].strip}%'")
        if @program.empty?
          render json: { error: 'Record not found' }
        else
          render json: @program
        end
      elsif params[:status]
        # byebug
        @program = @current_instructor.programs.where(status: params[:status].strip)
        if @program.empty?
          render json: { error: 'Record not found' }
        else
          render json: @program
        end
      end
    else
      render json: { message: 'Please provide required field' }
    end
  end

  def update
    @program = @current_instructor.programs.find(params[:id])
    return render json: { message: "Program has already #{params[:status]} status" } unless @program.status != params[:status]

    @program.update(status: params[:status])
    render json: { message: 'Status Updated Successfully' }
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  def login
    @instructor = User.find_by(email: params[:email], password: params[:password])
    return render json: { error: 'Invalid email and password' } unless @instructor
    return render json: { error: 'Please login with instructor credentials' } unless @instructor.type == 'Instructor'

    token = jwt_encode(user_id: @instructor.id)
    render json: { token: token, message: "#{@instructor.name} logged in Successfully:" }
  end

  def destroy
    @program = @current_instructor.programs.find(params[:id])
    if @program
      @program.destroy
      render json: { message: 'Program deleted Successfully' }
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: e.message
  end

  private

  def instruct_params
    params.permit(:name, :email, :password)
  end

  def program_params
    params.permit(:name, :category_id, :status, :video)
  end
end
