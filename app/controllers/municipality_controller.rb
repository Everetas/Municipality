require 'net/http'
require 'json'

class MunicipalityController < ApplicationController
  def index
    @streets = Street.all

    @uncleanedStreets = Array.new(@streets)

    for i in 1..3 do
      url = 'https://syntask.herokuapp.com/streets' + i.to_s + '.json'
      uri = URI(url)
      response = Net::HTTP.get(uri)
      @cleanedStreets = JSON.parse(response)['streets']

      for cleanedStreet in @cleanedStreets do
        @uncleanedStreets.reject!{ |hash| hash[:name] == cleanedStreet }
      end

      @uncleanedBuildings = Array.new
      for uncleanedStreet in @uncleanedStreets do
        buildings = Building.where(street_id: uncleanedStreet.id)
        for building in buildings do
          @uncleanedBuildings.push(building)
        end
      end
    end
  end
end
