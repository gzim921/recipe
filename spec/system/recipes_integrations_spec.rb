require 'rails_helper'

RSpec.describe 'RecipesIntegrations', type: :system do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }

  before do
    driven_by :selenium, using: :chrome

    visit login_path

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign In'
    end
  end

  describe 'Creating a Recipe' do
    it 'creates and shows the newly created Recipe' do
      name = 'Create new system spec'
      description = 'Description'
      instructions = 'This is the instruction'
      ingredients = 'This is the ingredient'
      within('nav') do
        click_on('New Recipe')
      end

      within('form') do
        fill_in 'recipe_name', with: name
        fill_in 'recipe_description', with: description
        fill_in 'recipe_instructions_attributes_0_name', with: instructions
        fill_in 'recipe_ingredients_attributes_0_name', with: ingredients
        click_on 'Create'
      end
      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(ingredients)
      expect(page).to have_content(instructions)
    end
  end

  describe 'Editing an recipe' do
    it 'edits and shows the recipe' do
      name = 'Edit system spec'
      description = 'Description'
      instructions = 'This is the edited instruction'
      ingredients = 'This is the edited ingredient'

      visit recipe_path(recipe)
      click_on 'Edit Recipe'

      within('form') do
        fill_in 'recipe_name', with: name
        fill_in 'recipe_description', with: description
        fill_in 'recipe_instructions_attributes_0_name', with: instructions
        fill_in 'recipe_ingredients_attributes_0_name', with: ingredients
        click_on 'Edit Recipe'
      end

      expect(page).to have_content(name)
      expect(page).to have_content(description)
      expect(page).to have_content(ingredients)
      expect(page).to have_content(instructions)
    end

    it 'edits just the instructions of recipe' do
      instructions = 'only edits this instruction'

      visit recipe_path(recipe)
      click_on('Edit Instructions')

      within('form') do
        fill_in 'recipe_instructions_attributes_0_name', with: instructions
        click_on 'Edit'
      end
      expect(page).to have_content(instructions)
    end
  end

  it 'edits just the ingredients of recipe' do
    ingredients = 'only edits this ingredient'

    visit recipe_path(recipe)
    click_on('Edit Ingredients')

    within('form') do
      fill_in 'recipe_ingredients_attributes_0_name', with: ingredients
      click_on 'Edit'
    end
    expect(page).to have_content(ingredients)
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

    it 'deletes the recipe ingredient' do
      visit recipe_path(recipe)
      click_on 'Edit Ingredients'
      check 'recipe_ingredients_attributes_0__destroy'

      click_on 'Edit'

      expect(page).to have_content('Recipe')
    end

  end
end
