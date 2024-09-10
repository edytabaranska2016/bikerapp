class AddDistanceToTrip < ActiveRecord::Migration[7.2]
  def change
    add_column :trips, :distance, :float
  end
end
