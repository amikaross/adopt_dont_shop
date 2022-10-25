require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many :adopt_app_pets }
    it { should have_many(:adopt_apps).through(:adopt_app_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end

      it 'returns case insensitive matches' do
        expect(Pet.search("claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end

    describe 'approval_status' do 
      it 'returns the approval status' do 
        app = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: app, pet: @pet_1, approval_status: 'approved')
        expect(@pet_1.approval_status(app.id)).to eq('approved')
      end
    end
  end
end
