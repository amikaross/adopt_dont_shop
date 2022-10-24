require "rails_helper"

RSpec.describe "admin shelters index" do 
  describe "As a visitor" do 
    describe "When I visit the admin shelter index" do 
      it "displays all the shelters in the system listed in alphabetical order by name" do 
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        visit "/admin/shelters"
        
        expect("Aurora shelter").to appear_before("Fancy pets of Colorado")
        expect("Fancy pets of Colorado").to appear_before("RGV animal shelter")
      end

      it "has a'Shelter's with Pending Applications' section with the name of shelters with pending applications" do 
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        pet_3 = shelter_2.pets.create(name: 'Lobster', breed: 'ACD', age: 5, adoptable: true)
        pet_4 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

        app_1 = AdoptApp.create!(name: "Amanda Smith", 
                                 street_address: "23 N South St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "Pending"
                                )
        app_2 = AdoptApp.create!(name: "Rachel Lavash", 
                                 street_address: "55 Plentiful Rd.", 
                                 city: "Aurora", 
                                 state: "CO", 
                                 zip_code: "80400", 
                                 description: "Taking care of thing.",
                                 status: "Pending"
                                )
        app_3 = AdoptApp.create!(name: "Rachel Lavash", 
                                 street_address: "55 Plentiful Rd.", 
                                 city: "Aurora", 
                                 state: "CO", 
                                 zip_code: "80400", 
                                 description: "Taking care of thing.",
                                 status: "In Progress"
                                )
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_1)
        AdoptAppPet.create!(adopt_app: app_1, pet: pet_3)
        AdoptAppPet.create!(adopt_app: app_2, pet: pet_2)
        AdoptAppPet.create!(adopt_app: app_3, pet: pet_4)

        visit "/admin/shelters"

        within("#shelters-pending") do 
          expect(page).to have_content("Shelter's with Pending Applications")
          expect(page).to have_content("Aurora shelter")
          expect(page).to have_content("RGV animal shelter")
          expect(page).to_not have_content("Fancy pets of Colorado")
        end
      end
    end
  end
end
