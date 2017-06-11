class Doctor < ActiveRecord::Base
  has_many :appointments,class_name: 'Appoinment'		
  has_many :patients, through: :appointments

  SET_FIRST_OPPOINMENT= "10:00"

  def self.check_doctor_time(doctor_id,appointment_time)
    begin
      doctor = Doctor.find doctor_id
      last_time = doctor.appointments.where("created_at >= ?", Date.current).last.created_at if doctor.appointments.present?
      return Time.parse(Doctor::SET_FIRST_OPPOINMENT) if last_time.nil?
      appointment_time = last_time + 20.minutes
      return appointment_time
    rescue Exception => e
      logger.info "set appointments error  #{e.message}"
    end
    
  end

  def get_patient_list get_date
    get_date = get_date.to_datetime
    self.patients.includes(:appointments).where("DATE(patients.created_at) = ?", get_date)  if self.patients.exists?
  end

end