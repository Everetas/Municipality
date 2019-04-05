require 'net/http'
require 'json'

class MunicipalityController < ApplicationController
  def index
    @streets = Street.all

    @uncleanedStreets = Array.new(@streets)
    @uncleanedBuildings = Array.new

    for i in 1..3 do
      url = 'https://syntask.herokuapp.com/streets' + i.to_s + '.json'
      uri = URI(url)
      response = Net::HTTP.get(uri)

      last_update = JSON.parse(response)['last_update'].to_date
      current_date = DateTime.now.to_date

      if current_date == last_update then
        @cleanedStreets = JSON.parse(response)['streets']
        for cleanedStreet in @cleanedStreets do
          @uncleanedStreets.reject!{ |hash| hash[:name] == cleanedStreet }
        end
      end

      for uncleanedStreet in @uncleanedStreets do
        buildings = Building.where(street_id: uncleanedStreet.id)
        for building in buildings do
          @uncleanedBuildings.push(building)
        end
      end

    end
  end
end
