class ChangeColumnNameUserIdFromReports < ActiveRecord::Migration
  def change
    rename_column :reports, :user_id, :user_email
    change_column :reports, :user_email, :string
  end
end
