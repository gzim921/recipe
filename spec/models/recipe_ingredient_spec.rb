require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:ingredient) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:ingredient) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).only_integer
      .with_message('should be added and should be a number') }
      it { should validate_uniqueness_of(:ingredient_id).scoped_to(:recipe_id)
        .with_message('should have one type of ingredient per recipe') }
  end
end