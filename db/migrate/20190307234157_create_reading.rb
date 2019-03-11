class CreateReading < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.integer :number, null: false
      t.float :temperature, null: false
      t.float :humidity, null: false
      t.float :battery_charge, null: false

      t.references :thermostat, foreign_key: { to_table: :thermostats }, index: true
    end
  end
end
