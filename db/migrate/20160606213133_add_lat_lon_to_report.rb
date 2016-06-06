class AddLatLonToReport < ActiveRecord::Migration
  def change
    add_column :reports, :lat, :string
    add_column :reports, :lon, :string
  end
end
