require "rails_helper" 

RSpec.describe AdoptApp, type: :model do
  describe "relationships" do 
    it { should have_many :adopt_app_pets }
    it { should have_many(:pets).through(:adopt_app_pets) }
  end

  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
  end

  describe "instance methods" do 
    describe "#all_pets_evaluated" do 
      it 'returns true only if all the pets on the applciation have been either approved or rejected' do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        app = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        app_pet_1 = AdoptAppPet.create!(adopt_app: app, pet: pet_1)
        app_pet_2 = AdoptAppPet.create!(adopt_app: app, pet: pet_2)
        app_pet_3 = AdoptAppPet.create!(adopt_app: app, pet: pet_3)
        
        expect(app.all_pets_evaluated?).to be false
        
        app_pet_1.update(approval_status: "approve")
        app_pet_2.update(approval_status: "approve")

        expect(app.all_pets_evaluated?).to be false

        app_pet_3.update(approval_status: "approve")

        expect(app.all_pets_evaluated?).to be true

        app_pet_3.update(approval_status: "reject")
        expect(app.all_pets_evaluated?).to be true
      end
    end

    describe "#rejected_pets" do 
      it "returns true only if one or more pet is rejected" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        app = AdoptApp.create!(name: "Amanda Ross", 
                                street_address: "3220 N Williams St.", 
                                city: "Denver", 
                                state: "CO", 
                                zip_code: "80205", 
                                description: "I want a best friend.",
                                status: "In Progress"
                              )
        AdoptAppPet.create!(adopt_app: app, pet: pet_1, approval_status: 'approve')
        expect(app.rejected_pets?).to be false
        AdoptAppPet.create!(adopt_app: app, pet: pet_2, approval_status: 'reject')
        expect(app.rejected_pets?).to be true
        AdoptAppPet.create!(adopt_app: app, pet: pet_3, approval_status: 'approve')
        expect(app.rejected_pets?).to be true
      end 
    end
  end
end