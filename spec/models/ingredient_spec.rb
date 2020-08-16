require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:recipe_ingredients) }
    it { should have_many(:recipes).through(:recipe_ingredients) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }

    it do
      should validate_uniqueness_of(:name)
        .with_message('should be unique')
    end
  end
end
