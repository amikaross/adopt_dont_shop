require "rails_helper"

RSpec.describe "the Admin AdoptApps show page" do 
  describe "as a visitor" do 
    describe "when I visit the Admin AdoptApps show page" do 
      before(:each) do 
        @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
        @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
        @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter.id)
        @shelter_2 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'beagle mix', name: 'Josie', shelter_id: @shelter_2.id)
        @pet_5 = Pet.create(adoptable: true, age: 3, breed: 'chihuahua mix', name: 'Jojo', shelter_id: @shelter_2.id)
        @pet_6 = Pet.create(adoptable: true, age: 1, breed: 'domestic longhair', name: 'Mako', shelter_id: @shelter_2.id)
        @app = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_1)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_2)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_3)
      end

      it "displays the application attributes" do  
        visit "admin/adopt_apps/#{@app.id}"
require 'pry'; binding.pry
        expect(page).to have_content("Bare-y Manilow")
        expect(page).to have_content("Lobster")
        expect(page).to have_content("Sylvester")
        expect(page).to_not have_content("Josie")
        expect(page).to_not have_content("Jojo")
        expect(page).to_not have_content("Mako")
      end

      xit "displays a approval radio button" do 
        visit "admin/adopt_apps/#{@app.id}"

        # expect(page).to_not have_link("Jojo", href: "/pets/#{@pet_5.id}")
        # expect(page).to have_field("search_pets")
        # fill_in "search_pets", with: "Jo"
        # click_button("Search")
        
        # expect(current_path).to eq("/adopt_apps/#{@app.id}")
        # within "##{@pet_4.id}" do
        #   expect(page).to have_content("Josie")
        #   expect(page).to have_button("Adopt This Pet")
        # end 
        # within "##{@pet_5.id}" do
        #   expect(page).to have_content("Jojo")
        #   expect(page).to have_button("Adopt This Pet")
        #   click_button("Adopt This Pet")
        # end 
        # expect(current_path).to eq("/adopt_apps/#{@app.id}")
        # expect(page).to have_link("Jojo", href: "/pets/#{@pet_5.id}")
      end
    end
  end

end