class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name
    @pending_shelters = Shelter.pending_applications
  end
end