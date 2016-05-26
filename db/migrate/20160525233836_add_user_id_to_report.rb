class AddUserIdToReport < ActiveRecord::Migration
  def change
    add_column :reports, :user_id, :int
  end
end
