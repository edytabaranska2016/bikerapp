require 'rails_helper'

describe TripsController do
  describe '#index' do
    specify do
      get :index

      expect(response.status).to eq(200)
    end
  end

  describe '#show' do
    let!(:trip) { create(:trip) }

    before { get :show, params: { id: trip.id } }

    it { expect(response.status).to eq(200) }
  end

  describe '#create' do
    let(:not_valid_params) {
      {
        start_address: 'Plac Europejski 20, Warszawa, Polska',
        destination_address: 'Grunwaldzka 46, 32-020 Wieliczka, Polska',
        price: 11.11,
        date: '2024-06-122'
      }
    }
    let(:valid_params) {
      {
        start_address: 'Plac Europejski 20, Warszawa, Polska',
        destination_address: 'Grunwaldzka 46, 32-020 Wieliczka, Polska',
        price: 11.11,
        date: '2024-06-12'
      }
    }

    context 'when valid params' do
      before { post :create, params: valid_params }

      it { expect(response.status).to eq(201) }
    end

    context 'when params not valid' do
      before { post :create, params: not_valid_params }

      it { expect(response.status).to eq(422) }
      it { expect(response.body).to eq("{\"date\":[\"can't be blank\",\"date should be in format YYYY-MM-DD\"]}") }
    end
  end

  describe '#destroy' do
    let!(:trip_to_destroy) { create(:trip) }

    before { delete :destroy, params: { id: trip_to_destroy.id } }

    it { expect(response.status).to eq(204) }
  end
end
