class MunicipalityController < ApplicationController
  def index
    @administrator = Administrator.find(1)
    @street = Street.find(1)
    @building = Building.find(1)
  end
end
