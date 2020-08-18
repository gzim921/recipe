require 'rails_helper'

RSpec.describe 'HomePages' do
  before do
    driven_by :rack_test

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
end
