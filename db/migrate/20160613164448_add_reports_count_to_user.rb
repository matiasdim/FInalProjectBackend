class AddReportsCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :reports_count, :integer
  end
end
