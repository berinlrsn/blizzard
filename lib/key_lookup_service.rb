module KeyLookupService
  def self.next_sequence_number(thermostat_id)
    "thermostat/#{thermostat_id}/sequence_number"
  end

  def self.save_reading(thermostat_id, sequence_number)
    "thermostat/#{thermostat_id}/reading/#{sequence_number}"
  end

  def self.get_readings(thermostat_id)
    "thermostat/#{thermostat_id}/reading/"
  end
end