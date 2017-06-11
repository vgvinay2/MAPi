class CreateAppoinments < ActiveRecord::Migration
  def change
    create_table :appoinments do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.string :time_of_oppoinment
      t.text :description

      t.timestamps null: false
    end
  end
end
