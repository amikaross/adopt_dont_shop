require "rails_helper"

RSpec.describe "the Admin AdoptApps show page" do 
  describe "as a visitor" do 
    describe "when I visit the Admin AdoptApps show page" do 
      it "displays every pet the application is for" do  
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        shelter_2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_4 = Pet.create(adoptable: true, age: 1, breed: 'beagle mix', name: 'Josie', shelter_id: shelter.id)
        pet_5 = Pet.create(adoptable: true, age: 3, breed: 'chihuahua mix', name: 'Jojo', shelter_id: shelter.id)
        pet_6 = Pet.create(adoptable: true, age: 1, breed: 'domestic longhair', name: 'Mako', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)

        visit "/admin/adopt_apps/#{app_1.id}"

        expect(page).to have_content("Bare-y Manilow")
        expect(page).to have_content("Lobster")
        expect(page).to have_content("Sylvester")
        expect(page).to_not have_content("Josie")
        expect(page).to_not have_content("Jojo")
        expect(page).to_not have_content("Mako")
      end

      it "displays an approval and reject button for each pet, which when clicked redirects you back to show page with buttons removed, and indicator of status showing" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        shelter_2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_4 = Pet.create(adoptable: true, age: 1, breed: 'beagle mix', name: 'Josie', shelter_id: shelter.id)
        pet_5 = Pet.create(adoptable: true, age: 3, breed: 'chihuahua mix', name: 'Jojo', shelter_id: shelter.id)
        pet_6 = Pet.create(adoptable: true, age: 1, breed: 'domestic longhair', name: 'Mako', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)

        visit "/admin/adopt_apps/#{app_1.id}"

        within "##{pet_2.id}" do 
          expect(page).to have_content("Lobster")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end

        within "##{pet_3.id}" do 
          expect(page).to have_content("Sylvester")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end

        within "##{pet_1.id}" do
          expect(page).to have_content("Bare-y Manilow")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")

          click_button("Approve")
        end

        expect(current_path).to eq("/admin/adopt_apps/#{app_1.id}")

        within "##{pet_1.id}" do 
          expect(page).to_not have_button("Reject")
          expect(page).to_not have_button("Approve")
          expect(page).to have_content("Approved")
          expect(page).to_not have_content("Rejected")
        end 
      end

      it "approving or rejecting a pet on one application has no effect on the status of the pet on another application" do 
        shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
        pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: shelter.id)
        shelter_2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet_4 = Pet.create(adoptable: true, age: 1, breed: 'beagle mix', name: 'Josie', shelter_id: shelter.id)
        pet_5 = Pet.create(adoptable: true, age: 3, breed: 'chihuahua mix', name: 'Jojo', shelter_id: shelter.id)
        pet_6 = Pet.create(adoptable: true, age: 1, breed: 'domestic longhair', name: 'Mako', shelter_id: shelter.id)
        app_1 = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)

        app_2 = AdoptApp.create!(name: "Kristen Jackson", 
                                street_address: "55 Orchard St.", 
                                city: "Aurora", 
                                state: "CO", 
                                zip_code: "80233", 
                                description: "Because I have pets that need friends.",
                                status: "In Progress"
                               )
                        AdoptAppPet.create!(adopt_app: app_2, pet: pet_1)
                        AdoptAppPet.create!(adopt_app: app_2, pet: pet_2)
                        AdoptAppPet.create!(adopt_app: app_2, pet: pet_3)
        
        visit "/admin/adopt_apps/#{app_1.id}"

        within "##{pet_1.id}" do 
          click_button("Approve")
        end 
        
        expect(current_path).to eq("/admin/adopt_apps/#{app_1.id}")

        within "##{pet_1.id}" do 
          expect(page).to_not have_button("Reject")
          expect(page).to_not have_button("Approve")
          expect(page).to have_content("Approved")
        end 

        visit "/admin/adopt_apps/#{app_2.id}"

        within "##{pet_1.id}" do 
          expect(page).to have_content("Bare-y Manilow")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        end 
      end
    end
  end

end