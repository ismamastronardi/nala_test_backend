class AbsenceRequestsController < ApplicationController
  before_action :set_absence_request, only: [:show, :update, :destroy]

  # GET /absence_requests
  def index
    @absence_requests = AbsenceRequest.all

    render json: @absence_requests
  end

  # GET /absence_requests/1
  def show
    render json: @absence_request
  end

  # POST /absence_requests
  def create
    @absence_request = AbsenceRequest.new(absence_request_params)

    if @absence_request.save
      render json: @absence_request, status: :created, location: @absence_request
    else
      render json: @absence_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /absence_requests/1
  def update
    if @absence_request.update(absence_request_params)
      render json: @absence_request
    else
      render json: @absence_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /absence_requests/1
  def destroy
    @absence_request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_absence_request
      @absence_request = AbsenceRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def absence_request_params
      params.require(:absence_request).permit(:employee_id, :start_date, :end_date, :type, :reason, :status)
    end
end