class InstructorsController < ApiController
  skip_before_action :user_authenticate, only: [:create]
  skip_before_action :instructor_check, only: [:create]
  skip_before_action :customer_check

  def create
    instructor = Instructor.new(instruct_params)
    if instructor.save
      render json: instructor, status: :created
    else
       render json: instructor.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'User Destroy Successfully' }
    else
      render json: { message: 'No Record Found' }
    end
  end

  private

  def instruct_params
    params.permit(:name, :email, :password)
  end

end
