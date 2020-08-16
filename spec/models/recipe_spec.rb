require 'rails_helper'

RSpec.describe Recipe do
  describe 'associations and dependencies' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:recipe_ingredients) }
    it { is_expected.to have_many(:ingredients) }
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:recipe_categories) }
    it { is_expected.to have_many(:ratings) }
  end

  describe 'accepts nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:categories) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:directions) }
  end
  describe 'validation of numericality' do
    it do
      should validate_numericality_of(:servings).
        with_message("can't be blank and has to be a number between 1 and 20")
    end

    it { should validate_numericality_of(:cooking_time).only_integer }
  end
end
