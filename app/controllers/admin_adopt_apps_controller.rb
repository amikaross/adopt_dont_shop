class AdminAdoptAppsController < ApplicationController
  def show
    @adopt_app = AdoptApp.find(params[:id])
    @pets = @adopt_app.pets
  end

  def update
      if params[:description] != nil
      @adopt_app.update(:description => params[:description], :status => "Pending")
    end
    redirect_to "admin/adopt_apps/#{@adopt_app.id}"
  end
end