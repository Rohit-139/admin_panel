class ProgramsController < ApplicationController
  before_action :instructor_authenticate_request
  skip_before_action :customer_authenticate_request

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  def index
  end

  def show
    # @program = @current_instructor.fitnessprograms.find_by(id:params[:id])
    # render json: @program
  end

  def create
    @program=@current_instructor.programs.new(program_params)

    @program.video.attach(params[:video])
    if @program.save
      render json: {message: @program.video.url}
    else
      render json: {error: @program.errors}
    end
  end

  private
    def program_params
      params.permit(:name, :category_id, :status, :video)
    end
end
