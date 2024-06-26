require 'pagy/extras/metadata'

class AbsenceRequestsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user
  before_action :set_employee, only: [:index, :create]
  before_action :set_absence_request, only: [:show, :update, :destroy]

  # GET /requests
  def index
    if @employee.present?
      absence_requests = @employee.absence_requests
    else
      absence_requests = AbsenceRequest.all
    end
    if params[:status].present?
      absence_requests = absence_requests.where(status: params[:status])
    end
    @pagy, paginated_absence_requests = pagy(absence_requests, items: 10)
    render json: {absence_request: paginated_absence_requests, pagy: { pages: @pagy.pages, current_page: @pagy.page }}
  end

  # GET /absence_requests/1
  def show
    render json: @absence_request
  end

  # POST /absence_requests
  def create
    unless @employee
      render json: { error: "Employee not found" }, status: :not_found
      return
    end

    @absence_request = @employee.absence_requests.new(absence_request_params)

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

    def set_employee
      @employee = Employee.find_by(id: params[:employee_id])
    end
  
    # Only allow a list of trusted parameters through.
    def absence_request_params
      params.require(:absence_request).permit(:employee_id, :start_date, :end_date, :request_type, :reason, :status)
    end
end
