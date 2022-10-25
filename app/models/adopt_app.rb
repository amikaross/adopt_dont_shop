class AdoptApp < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code

  has_many :adopt_app_pets
  has_many :pets, through: :adopt_app_pets

  def approved_application? 
    pets.all? { |pet| pet.approval_status(id) == "approve" }
  end

  def rejected_application? 
    pets.all? { |pet| pet.approval_status(id) != nil } && pets.any? { |pet| pet.approval_status(id) == "reject" }
  end
end