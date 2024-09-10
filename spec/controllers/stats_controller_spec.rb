require 'rails_helper'

describe StatsController do
  describe '#weekly' do
    specify do
      get :weekly

      expect(response.status).to eq(200)
    end
  end

  describe '#weekly' do
    specify do
      get :monthly

      expect(response.status).to eq(200)
    end
  end
end
