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
    describe "#approved_application" do 
      it 'has all pets on application approved' do 
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
        AdoptAppPet.create!(adopt_app: app, pet: pet_2, approval_status: 'approve')
        AdoptAppPet.create!(adopt_app: app, pet: pet_3, approval_status: 'approve')
        
        expect(app.approved_application?).to be true
      end
    end

    describe "#rejected_application" do 
      it "returns true only if all pets have been either approved or rejected and one or more is rejected" do 
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
        AdoptAppPet.create!(adopt_app: app, pet: pet_2, approval_status: 'reject')
        AdoptAppPet.create!(adopt_app: app, pet: pet_3, approval_status: 'approve')
        
        expect(app.rejected_application?).to be true
      end 
    end
  end
end