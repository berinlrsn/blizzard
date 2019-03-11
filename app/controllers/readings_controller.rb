class ReadingsController < ApplicationController
  before_action :set_thermostat

  def create
    sequence_number = @thermostat.save_reading(reading_params.to_h)
    render json: { status: :success, sequence_number: sequence_number }
  end

  def show
    reading = @thermostat.get_reading(params[:sequence_number].to_i)

    if reading.present?
      render json: { status: :success, reading: reading.to_json }
    else
      render json: { status: :failure, message: "Reading not found" }
    end
  end

  def stats
    render json: { status: :success, stats: @thermostat.stats }
  end

  private

  def set_thermostat
    token = params.delete(:household_token)
    @thermostat = Thermostat.where(household_token: token).first

    if @thermostat.blank?
      render json: { status: :failure, message: "Invalid household token"}
    end
  end

  def reading_params
    params.permit( :temperature, :humidity, :battery_charge)
  end
end
