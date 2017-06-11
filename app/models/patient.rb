class Patient < ActiveRecord::Base
  has_many :appointments,class_name: 'Appoinment'
  has_many :doctors, through: :appointments
end
