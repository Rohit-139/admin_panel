class ProgramsController < ApiController

  load_and_authorize_resource

  def index
    if params[:name].present?
      @program = @current_user.programs.where("name like ?","%#{params[:name]}%")
    else
      @program = @current_user.programs
    end
    reuse(@program, 'name')
  end

  def show
    program = @current_user.programs.find_by(id: params[:id])
    reuse(program, 'id')
  end

  def create
    program = @current_user.programs.new(program_params)
    if program.save
      render json: program, status: :created
    else
      render json: { error: program.errors.messages }, status: :unprocessable_entity
    end
  end

  def filter_on_status_basis
    programs = @current_user.programs.where(status: params[:status])
    reuse(programs, 'status')
  end

  def update
    program = @current_user.programs.find_by(id:params[:id])
    if program.status == params[:status]
      render json: { message: "Program has already #{params[:status]} status" }
    else
      program.update(status: params[:status])
      render json: { message: 'Status Updated Successfully' }, status: :ok
    end
  rescue NoMethodError => e
    render json: {message: 'No Record found with this id'}
  end

  def destroy
    program = @current_user.programs.find_by(id:params[:id])
    if program.present?
      program.destroy
      render json: { message: 'Program deleted Successfully' }, status: :ok
    else
      render json: { message: 'No Record Found'}, status: :not_found
    end
  end

  private

  # def authorization
  #   authorize Program
  # end

  def reuse(program, msg)
    if program.present?
      render json: program, status: :ok
    else
      render json: {message: "No record found with this #{msg}"}
    end
  end

  def program_params
    params.permit(:name, :category_id, :status, :video)
  end
end
