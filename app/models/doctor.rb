class Doctor < ActiveRecord::Base
  has_many :appointments,class_name: 'Appoinment'		
  has_many :patients, through: :appointments
  
  def self.available_doctor
    Doctor.all
  end
  def self.check_doctor_time(doctor_id,appointment_time)
    doctor = Doctor.find_by_id doctor_id
    last_time = doctor.appointments.where("created_at >= ?", Date.current).last.created_at.strftime("%H:%M") if doctor.appointments.present?
    return appointment_time if last_time.nil?
    # appointment_time ="appointment_time".to_datetime.strftime("%H:%M")
    # get_appointment_time = Time.parse(appointment_time) - Time.parse(last_time) > 20 ? (Time.parse(appointment_time) - Time.parse(last_time) : appointment_time
    byebug
    return appointment_time = Time.parse(appointment_time) if (Time.parse(appointment_time) - Time.parse(last_time)) > 20
    # Time.at(appointment_time).utc.strftime("%H:%M:%S")
  end
end
