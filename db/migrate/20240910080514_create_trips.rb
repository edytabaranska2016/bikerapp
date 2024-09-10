class CreateTrips < ActiveRecord::Migration[7.2]
  def change
    create_table :trips do |t|
      t.string :start_address
      t.string :destination_address
      t.decimal :price, precision: 8, scale: 2
      t.date :date

      t.timestamps
    end
  end
end
