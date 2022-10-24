class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
  has_many :adopt_app_pets
  has_many :adopt_apps, through: :adopt_app_pets

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def approval_status(adopt_app_id)
    row = AdoptAppPet.find_by(pet_id: id, adopt_app_id: adopt_app_id)
    row.approval_status
  end

end
