require 'pagy/extras/metadata'
require 'pagy/extras/array' 

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
    if params[:start_date].present?
      absence_requests = absence_requests.where("start_date >= ?", params[:start_date])
    end
    if params[:end_date].present?
      absence_requests = absence_requests.where("start_date <= ?", params[:end_date])
    end
    if params[:request_type].present?
      absence_requests = absence_requests.where(request_type: params[:request_type])
    end

    completed_requests = absence_requests.map do |request|
      employee = Employee.find(request.employee_id)
      {
        id: request.id,
        employee_name: employee.name,
        employee_email: employee.email,
        start_date: request.start_date,
        end_date: request.end_date,
        request_type: request.request_type,
        reason: request.reason,
        status: request.status,
        days_requested: request.days_requested
      }
    end

    @pagy, paginated_absence_requests = pagy_array(completed_requests, items: 4)
    render json: {
      count: absence_requests.count,
      absence_requests: paginated_absence_requests,
      pagy: { pages: @pagy.pages, current_page: @pagy.page }
    }
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
    render json: { message: "Absence request deleted successfully" }
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
