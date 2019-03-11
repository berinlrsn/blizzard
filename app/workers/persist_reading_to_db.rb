class PersistReadingToDB
  include Sidekiq::Worker

  def perform(thermostat_id, redis_key)
    thermostat = Thermostat.where(id: thermostat_id).first

    json = $redis.hgetall(redis_key)
    reading = thermostat.readings.new(json)
    reading.save!

    $redis.del(redis_key)
  end
end
