require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    driven_by(:rack_test)

    visit root_path
  end

  it 'shows the github projects' do
    expected = page.has_link?('Recipe')

    expect(expected).to be true
  end

  context 'when no user is logged in' do
    it 'shows the Login link' do
      expected = page.has_link?('Login')

      expect(expected).to be true
    end

    it 'shows the Sign Up link' do
      expected = page.has_link?('Sign Up')

      expect(expected).to be true
    end
  end

  context 'when a user is signed in into the app' do
    before do
      user = create(:user)

      visit "/login/"
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Login'
      visit "users/#{user.id}"
    end

    it 'shows the Home link' do
      expecting = page.has_link?('Home')

      expect(expecting).to be true
    end

    it 'shows the All recipes link' do
      expecting = page.has_link?('Recipes')

      expect(expecting).to be true
    end

    it 'shows the newest recipe link' do
      expecting = page.has_link?('Newest Recipe')

      expect(expecting).to be true
    end

    it 'shows categories link' do
      expecting = page.has_link?('Categories')

      expect(expecting).to be true
    end

    it 'shows the Logout link' do
      expecting = page.has_link?('Log Out')

      expect(expecting).to be true
    end
  end

  context 'when an article is present' do
    let!(:recipe) do
      create(:recipe)
    end

    before do
      visit root_path
    end

    it 'shows the recipe title' do
      expecting = page.has_content?(recipe.name)
      expect(expecting).to be true
    end
  end
end
