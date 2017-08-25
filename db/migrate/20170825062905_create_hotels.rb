class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :image
      t.string :name
      t.text :summary
      t.string :hotel_url
      t.string :street_address
      t.string :phone_number

      t.timestamps
    end
  end
end
