require "rails_helper"
require 'geocoder'

RSpec.describe SearchController, type: :controller do
  describe "GET #index" do
    it "fulfills the request with a 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "retrieves a latitude and longitude" do
      @lat = request.location.latitude
      @lng = request.location.longitude
      expect(@lat).not_to be_nil
      expect(@lng).not_to be_nil
    end
  end

  describe "GET #result" do
    it "fulfills the request with a 200 status code" do
      get :results, :params => {'pizza' => 'krust', 'limit' => '5'}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

end
