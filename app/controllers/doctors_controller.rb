class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]

  def index
    doctors = Doctor.all
    if doctors.present?
      render json: { info: doctors, status: 200 }
    else
      render json: { info: doctors ,status: 200, message: "No Record exists"}
    end
  end

  def show
    if @doctor.present?
      render json: { info: @doctor, status: 200 }
    else
      render json: { info: @doctor.errors ,status: 200 }
    end
  end

  def create
    doctor = Doctor.new(doctor_params)
      if doctor.save
        render json: {info: doctor, status: 201} 
      else
        render json: { errors: doctor.errors, status: :unprocessable_entity } 
      end
  end

  def update
      if @doctor.update(doctor_params)
        render json:{ info: @doctor, status: :ok }
      else
        render json: { errors: @doctor.errors, status: :unprocessable_entity } 
      end
  end

  def destroy
     if @doctor
      @doctor.destroy
      render json:{ status: 200,message:"Deleted Succesfully" }
      else    
        render json: { errors: @doctor, status: :unprocessable_entity } 
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      begin
         @doctor = Doctor.find(params[:id])
      rescue StandardError => e
         render json: { errors: e.message, status: 412 } 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doctor_params
      params.require(:doctor).permit(:name, :qualification, :experiance, :specilazation)
    end
end
