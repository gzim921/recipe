require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }

    it { should belong_to(:category) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:category_id).scoped_to(:recipe_id)
      .with_message('should have one type of category per recipe') }
  end
end