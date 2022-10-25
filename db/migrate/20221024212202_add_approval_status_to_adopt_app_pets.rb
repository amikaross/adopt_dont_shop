class AddApprovalStatusToAdoptAppPets < ActiveRecord::Migration[5.2]
  def change
    add_column :adopt_app_pets, :approval_status, :string
  end
end
