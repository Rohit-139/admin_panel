class EnrollsController < ApiController

  load_and_authorize_resource

  def index
    if params[:name].present?
      @enroll = @current_user.enrolls.where("name LIKE '%#{params[:name]}'")
    else
      @enroll = @current_user.enrolls
    end
    reuse(@enroll)
  end

  def show
    @enroll = @current_user.enrolls.find_by(id: params[:id])
    reuse(@enroll)
  end

  def category_wise_courses
    programs = Program.joins(:category).where('categories.name like ?',"%#{params[:name]}%")
    reuse(programs)
  end

  def create
    program = Program.find_by(name: params[:name], status: 'active')
    if program.present?
      enroll = @current_user.enrolls.new(name: program.name, level: 'started', program_id: program.id)
      if enroll.save
        render json: { message: 'You have successfully enrolled' }, status: :created
      else
        render json:  enroll.errors.messages
      end
    else
      render json: { message: 'No Course found with this name' }
    end
  end

  def update
    enroll = @current_user.enrolls.find_by(id:params[:id])
    if enroll.level == params[:status]
      render json: { message: "Program has already #{params[:status]} status" }
    else
      @current_user.enrolls.update(level: 'finished')
      render json: 'Successfully Marked as Finished', status: :ok
    end
  end

  def destroy
    enroll = @current_user.enrolls.find_by(id:params[:id])
    if enroll.present?
      enroll.destroy
      render json: { message: 'Deleted Successfully' }
    else
      render json: { message: 'No Record Found' }
    end
  end

  private

  # def authorizeration
  #   authorize User
  # end

  def reuse(enroll)
    if enroll.present?
      render json: enroll, status: :ok
    else
      render json: { message: 'Record not found' }
    end
  end
end
