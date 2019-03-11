require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ReadingsController, type: :controller do
  before(:each) do
    @thermostat = Thermostat.first
    @reading = Reading.first
    @reading_hash = {
        household_token: @thermostat.household_token,
        temperature: 200,
        humidity: 28,
        battery_charge: 100
    }
  end

  it "should creates a reading" do
    expect {
      Sidekiq::Testing.inline! do
        post :create, params: @reading_hash
      end
    }.to change{Reading.count}.by(1)
  end

  it "gives an error response if household token is invalid" do
    post :create, params: @reading_hash.merge(household_token: "non-existent token")
    expect(response.body).to match("Invalid household token")
  end

  it "should return readings which have not persisted yet" do
    post :create, params: @reading_hash
    sequence_number = JSON.parse(response.body)["sequence_number"]

    get :show, params: {
        household_token: @thermostat.household_token,
        sequence_number: sequence_number
    }

    response_hash = parse_show_response(response.body)

    expect(response).to be_successful
    expect(response_hash[:temperature]).to eq(@reading_hash[:temperature])
  end

  it "should return reading which have been saved" do
    get :show, params: {
        household_token: @reading.thermostat.household_token,
        sequence_number: @reading.number
    }

    response_hash = parse_show_response(response.body)
    expect(response_hash[:number]).to eq(@reading.number)
  end

  it "should return stats" do
    get :stats, params: { household_token: @thermostat.household_token }
    expect(response).to be_successful
  end

  private

  def parse_show_response(response_body)
    data = JSON[response_body]["reading"]

    JSON.parse(data).with_indifferent_access
  end

end
