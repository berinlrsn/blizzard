class Reading < ApplicationRecord
  validates_presence_of :temperature, :battery_charge, :humidity, :number
  belongs_to :thermostat
end
