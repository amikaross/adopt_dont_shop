require "rails_helper"

RSpec.describe "The admin/adopt_apps update" do 
  describe "As an visitor" do 
    describe "When I visit admin/adopt_apps/:id" do 
      it "approving all pets on an application means the application is approved" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "Pending"
                                )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)
    
        visit "/admin/adopt_apps/#{app_1.id}"
    
        within "##{pet_1.id}" do 
          click_button("Approve")
        end 
    
        within "##{pet_2.id}" do 
          click_button("Approve")
        end 
    
        expect(page).to have_content("Status: Pending")
    
        within "##{pet_3.id}" do 
          click_button("Approve")
        end 
    
        expect(current_path).to eq("/admin/adopt_apps/#{app_1.id}")
        expect(page).to have_content("Status: Approved")
      end
    
      it "rejecting one or pets on an application means the application is rejected" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "Pending"
                                )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)
    
        visit "/admin/adopt_apps/#{app_1.id}"
    
        within "##{pet_1.id}" do 
          click_button("Approve")
        end 
    
        within "##{pet_2.id}" do 
          click_button("Approve")
        end 
    
        expect(page).to have_content("Status: Pending")
    
        within "##{pet_3.id}" do 
          click_button("Reject")
        end 
    
        expect(current_path).to eq("/admin/adopt_apps/#{app_1.id}")
        expect(page).to have_content("Status: Rejected")
      end

      it "accepting an application means that all pets for the application are no longer adoptable" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "Pending"
                                )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)
    
        visit "/admin/adopt_apps/#{app_1.id}"
    
        within "##{pet_1.id}" do 
          click_button("Approve")
        end 
    
        within "##{pet_2.id}" do 
          click_button("Approve")
        end 
    
        within "##{pet_3.id}" do 
          click_button("Approve")
        end 
    
        expect(current_path).to eq("/admin/adopt_apps/#{app_1.id}")
        expect(page).to have_content("Status: Approved")
        app = AdoptApp.find(app_1.id)
        expect(app.pets.all? { |pet| pet.adoptable == false }).to eq(true)
      end
    end
  end
end