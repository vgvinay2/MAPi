class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name
      t.text :address
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
