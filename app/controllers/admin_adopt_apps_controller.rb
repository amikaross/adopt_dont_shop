class AdminAdoptAppsController < ApplicationController
  def show
    @adopt_app = AdoptApp.find(params[:id])
    @pets = @adopt_app.pets
  end

  def update
    adopt_app = AdoptApp.find(params[:id])
    adopt_app_pets = AdoptAppPet.find_by(pet_id: params[:pet_id], adopt_app_id: params[:id])
    adopt_app_pets.update(:approval_status => params[:approval_status])
    if adopt_app.all_pets_evaluated? && adopt_app.rejected_pets?
      adopt_app.update(status: "Rejected")
    elsif adopt_app.all_pets_evaluated?
      adopt_app.update(status: "Approved")
      adopt_app.pets.update_all(adoptable: false)
    end
    redirect_to "/admin/adopt_apps/#{adopt_app.id}"
  end
end
