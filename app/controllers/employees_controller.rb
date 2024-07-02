require 'pagy/extras/metadata'
require 'pagy/extras/array' 

class EmployeesController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employees
  def index
    @employees = Employee.all

    if params[:name].present?
      @employees = @employees.where("name LIKE ?", "%#{params[:name]}%")
    end

    if params[:email].present?
      @employees = @employees.where("email LIKE ?", "%#{params[:email]}%")
    end

    completed_employees = @employees.map do |employee|
      {
        id: employee.id,
        name: employee.name,
        email: employee.email,
        days_absent: employee.days_absent,
        days_requested: employee.days_requested
      }
    end
  
    @pagy, paginated_employees = pagy_array(completed_employees, items: 5)
    render json: {
      employees: paginated_employees,
      pagy: { pages: @pagy.pages, current_page: @pagy.page
      }}
  end

  # GET /employees/1
  def show
    @employee = Employee.find(params[:id])
    @absence_requests = @employee.absence_requests
    @days_absent = @employee.days_absent

    render json: {
      employee: @employee,
      absence_requests: @absence_requests,
      days_absent: @days_absent
    }
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    ActiveRecord::Base.transaction do
      @employee.absence_requests.destroy_all
      @employee.destroy
    end
    render json: {message: "Employee and associated absence requests deleted successfully"}
  rescue ActiveRecord::RecordNotDestroyed
    render json: {message: "Employee and associated absence requests couldn't be deleted"}, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound
    render json: {message: "Employee not found"}, status: :not_found
  rescue StandardError => e
    render json: {message: e.message}, status: :unprocessable_entity
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:name, :email)
    end
end
