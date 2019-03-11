class Thermostat < ApplicationRecord
  validates_uniqueness_of :household_token
  has_many :readings

  require 'key_lookup_service'

  def save_reading(params)
    params[:number] = next_sequence_number!
    key = KeyLookupService.save_reading(id, params[:number])

    $redis.mapped_hmset(key, params.to_h)
    PersistReadingToDB.perform_async(id, key)

    return params[:number]
  end

  def get_reading(sequence_number)
    key = KeyLookupService.save_reading(id, sequence_number)
    json = $redis.hgetall(key)

    if json.present?
      Reading.new(json)
    else
      readings.where(number: sequence_number).first
    end
  end

  def stats
    remaining_readings = yet_to_be_saved_readings

    [:temperature, :humidity, :battery_charge].each_with_object({}) do |key, hash|
      values = readings.pluck(key) + remaining_readings.map { |r| r.send(key) }

      hash[key] = {
          average: values.inject(0.0) { |sum, el| sum + el } / values.size,
          max: values.max,
          min: values.min
      }
    end
  end

  private

  # Readings which are present in Redis, but are not saved to database yet.
  def yet_to_be_saved_readings
    cursor = nil
    readings = []

    key = KeyLookupService.get_readings(id)
    while cursor != "0" do
      cursor, keys = $redis.scan(cursor, { match: "#{key}*"})

      keys.each do |k|
        json = $redis.hgetall(k)
        readings << Reading.new(json)
      end
    end

    readings
  end

  def next_sequence_number!
    key = KeyLookupService.next_sequence_number(id)
    $redis.incr(key)
  end
end
