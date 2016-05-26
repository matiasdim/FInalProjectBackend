class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :reporterName
      t.string :reporterCel
      t.string :reporterPhone
      t.string :reporterEmail
      t.text :reporterObservations
      t.references :pet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
