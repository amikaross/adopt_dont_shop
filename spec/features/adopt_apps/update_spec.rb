require 'rails_helper'

RSpec.describe 'the application update' do
  describe "as a visitor" do 
    describe "when I visit the AdoptApps show page" do 
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
      end

      it "has an 'adopt this Pet' button which adds Pets to the adoption" do 
        visit "/adopt_apps/#{@app.id}"
        fill_in "search_pets", with: "Jo"
        click_button("Search")
        within "##{@pet_5.id}" do
          click_button("Adopt This Pet")
        end 
        expect(current_path).to eq("/adopt_apps/#{@app.id}")
        expect(page).to have_link("Jojo", href: "/pets/#{@pet_5.id}")
        expect(@app.pets).to eq([@pet_5])
      end 
      
      it 'has a section to submit my application when one or more pets are added' do
        visit "/adopt_apps/#{@app.id}"
        expect(page).to_not have_content('Lobster')
        expect(page).to_not have_field(:description)
        expect(page).to_not have_content("Why I would make a good owner for these pet(s):")
        
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_1)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_2)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_3)
        
        visit "/adopt_apps/#{@app.id}"
        expect(page).to have_link('Lobster', href: "/pets/#{@pet_2.id}")
        expect(page).to have_field(:description)
        expect(page).to have_content("Why I would make a good owner for these pet(s):")
      end

      it 'updates applciation with description and submits' do 
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_1)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_2)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_3)
        visit "/adopt_apps/#{@app.id}"
        expect(page).to_not have_content('I have a nice, loving home')
        fill_in 'description', with: 'I have a nice, loving home'
        click_button("Sumbit")
        expect(current_path).to eq("/adopt_apps/#{@app.id}")
        expect(page).to have_content("Description: I have a nice, loving home")
        expect(page).to have_content("Status: Pending")
        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Search pets by name:")
      end
    end
  end
end