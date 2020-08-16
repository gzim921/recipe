require 'rails_helper'

RSpec.describe 'HomePages', type: :system do
  before do
    driven_by :selenium, using: :chrome

    visit root_path
  end

  it 'shows the home page link' do
    expected = page.has_link?('All Recipes')

    expect(expected).to be true
  end

  context 'when no user is logged in' do
    it 'shows the Log In link' do
      expected = page.has_link?('login')

      expect(expected).to be true
    end

    it 'shows the Sign Up link' do
      expected = page.has_link?('Register')

      expect(expected).to be true
    end
  end

  context 'when a user is signed in into the app' do
    before do
      user = create(:user)

      visit login_path

      within('form') do
        fill_in 'Email', with: user.mail
        fill_in 'Password', with: user.password
        click_on 'Sign In'
      end

      visit root_path
    end

    it 'shows the New Recipe link' do
      expecting = page.has_link?('New Recipe')

      expect(expecting).to be true
    end

    it 'shows the My Profile link' do
      expecting = page.has_link?('My Profile')

      expect(expecting).to be true
    end

    it 'shows the Logout link' do
      expecting = page.has_link?('logout')

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
