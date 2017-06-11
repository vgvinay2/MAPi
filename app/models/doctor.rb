class Doctor < ActiveRecord::Base
  has_many :appointments,class_name: 'Appoinment'		
  has_many :patients, through: :appointments
  
  def self.available_doctor
    Doctor.all
  end
  def self.check_doctor_time(doctor_id,appointment_time)
    begin
      doctor = Doctor.find doctor_id
      last_time = doctor.appointments.where("created_at >= ?", Date.current).last.created_at.strftime("%H:%M") if doctor.appointments.present?
      return appointment_time if last_time.nil?
      appointment_time = last_time + 20.minutes
      return appointment_time
    rescue Exception => e
      logger.info "set appointments error  #{e.message}"
    end
    
  end
end
