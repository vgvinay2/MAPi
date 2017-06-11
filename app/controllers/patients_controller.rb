class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :update, :destroy]

  def index
    patients = Patient.all
    if patients.present?
      render json: { info: patients, status: 200 }
    else
      render json: { info: patients ,status: 200, message: "No Record exists"}
    end
  end

  def show
  end

  def create
    patient = Patient.new(patient_params)
    if patient.save
      patient.appointments.create(appoinment_params)
      render json: {info: patient, status: 201, message: "created successfully"} 
    else
      render json: { errors: patient.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @patient.update(patient_params)
     render json: { status: :ok, info: @patient, message: "updated successfully" }
   else
    render json: { errors: @patient.errors, status: :unprocessable_entity }
  end
end

def destroy
  if @patient
    @patient.destroy
    render json:{ status: 200, message:"Deleted Succesfully" }
  else
    render json: { errors: @patient.errors, status: :unprocessable_entity } 
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      begin
        @patient = Patient.find(params[:id])
      rescue StandardError => e
         render json: { errors: e.message, status: 412 } 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :address, :phone_number,:doctor_id)
      render json:{ status: 404, message:"send proper parameters" } if params[:patient].empty?
    end

    def appoinment_params
      params[:oppoinment][:time_of_oppoinment] = Doctor.check_doctor_time(params[:oppoinment][:doctor_id],params[:oppoinment][:time_of_oppoinment])
      params.require(:oppoinment).permit(:doctor_id, :description, :time_of_oppoinment)
    end
  end
