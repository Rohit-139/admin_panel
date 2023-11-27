class InstructorsController < ApiController

  skip_before_action :user_authenticate, only: [:create]
  load_and_authorize_resource except: :create

  def destroy
    if @current_user.destroy
      render json: { message: 'User Destroy Successfully' }
    else
      render json: { message: 'No Record Found' }
    end
  end


end
