require 'httparty'
require 'json'
require 'pry'

# Key is hid with ENV variables using Figaro
API_KEY = "AIzaSyBITsYDCU8mfLW9exGEBrU6vy5xTNyV264"
class GooglePlaces

  # Lat and Lng are passed in using Geocoder gem. Variables passes into google places api
  # in order to find pizza places nearby.
  def find_places(lat, lng)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=300&type=restaurant&keyword=pizza&rankBy=distance&key=#{API_KEY}")
    sleep(1)
    data = JSON.parse(response.body)['results']
    name = []
    data.each do |json|
      name << json['name']
    end
    name.first(8)
  end

  # Lat and Lng are found using google geocde api. We pass in address scraped from Yelp
  # then the lat lng are passed into google maps api to display map location of pizza shop.
  def geocode(address)
    response = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{address.gsub(' ','+')}&key=#{API_KEY}")
    sleep(1)
    data = JSON.parse(response.body)['results']
    location = []
    location << data[0]['geometry']['location']['lat']
    location << data[0]['geometry']['location']['lng']
  end
end
