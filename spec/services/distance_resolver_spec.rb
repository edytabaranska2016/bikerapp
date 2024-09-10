require 'rails_helper'

describe DistanceResolver do
  let(:trip) { create(:trip) }

  subject(:service) { DistanceResolver.new(trip).perform }

  context 'when there is no locations for trip object' do
    it { expect(service).to eq(0) }
  end

  context 'when there are locations to calculate distance' do
    let(:start_location) { create(:location, :start) }
    let(:destination_location) { create(:location, :destination) }
    let(:start_coordinates) { [start_location.latitude, start_location.longitude] }
    let(:destination_coordinates) { [ destination_location.latitude, destination_location.longitude ] }
    let(:distance) { 257.290568 }

    before do
      allow(Geocoder::Calculations).to receive(:distance_between).with(start_coordinates, destination_coordinates).and_return(distance)
    end

    it { expect(service).to eq(257.29) }
  end
end
