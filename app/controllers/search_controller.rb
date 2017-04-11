class SearchController < ApplicationController

  def index
    @lat = request.location.latitude #Geocoder gem finds Lat Lng
    @lng = request.location.longitude
    @shops = GooglePlaces.new.find_places(@lat, @lng)
  end

  # If user inputs pizza shop that doesn't exist, 'No Result' will be returned
  # from Scrape.scrape_shop and will be redirect back to path with flash notice.
  def results
    @pizza_shop = params['pizza']['shop']
    @limit = params['pizza']['limit'].to_i - 1
    @scrape = Scrape.new.scrape_shop(@pizza_shop, @limit)
    if @scrape == 'No Result'
      redirect_to root_path, notice: 'No results found. Please try again.'
    else
      @scrape.each do |shop_hash|
        @shop = shop_hash[:shop]
        @address = shop_hash[:address]
        @phone = shop_hash[:phone]
        @time = shop_hash[:time]
      end
      @location = GooglePlaces.new.geocode(@address)
    end
  end
  
end
