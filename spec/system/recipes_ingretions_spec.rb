require 'rails_helper'

RSpec.describe 'RecipesIngretions', type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    driven_by(:rack_test)

    visit root_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Login'
    visit "users/#{user.id}"
    
  end

  describe 'Creating a Recipe' do
    it 'creates and shows the newly created Recipe' do
      name = 'Create new recipe'
      directions = 'Directions'
      cooking = 1
      servings = 2
      click_on('Submit')


        fill_in 'recipe_name', with: name
        fill_in 'recipe_direction', with: directions
        fill_in 2, with: cooking
        fill_in 2, with: servings
        click_on 'Submit'

      expect(page).to have_content(name)
      expect(page).to have_content(directions)
      expect(page).to have_content(cooking)
      expect(page).to have_content(servings)
    end
  end

  describe 'Editing an recipe' do
    it 'edits and shows the recipe' do
      name = 'Edit system spec'
      directions = 'Description'
      cooking = 2
      servings = 2

      visit recipe_path(recipe)
      click_on 'Edit Recipe'

        fill_in 'recipe_name', with: name
        fill_in 'recipe_description', with: directions
        fill_in 'recipe_instructions_attributes_0_name', with: cooking
        fill_in 'recipe_ingredients_attributes_0_name', with: servings
        click_on 'Edit Recipe'

      expect(page).to have_content(name)
      expect(page).to have_content(directions)
      expect(page).to have_content(cooking)
      expect(page).to have_content(servings)
    end
  end
  describe 'Deleting an recipe or its content' do
    it 'deletes the recipe and redirect to index view' do
      visit recipe_path(recipe)
      click_on 'Delete Recipe'
      expect(page).to have_content('Recipes')
    end

    it 'deletes the recipe instruction' do
      visit recipe_path(recipe)
      click_on 'Edit Instructions'
      check 'recipe_instructions_attributes_0__destroy'

      click_on 'Edit'

      expect(page).to have_content('Recipe')
    end
  end
end
