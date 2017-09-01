class CreateHotelServices < ActiveRecord::Migration[5.1]
  def change
    create_table :hotel_services do |t|
      t.integer :hotel_id
      t.string :name
      t.time :start_time
      t.time :end_time

      t.timestamps
    end
  end
end
