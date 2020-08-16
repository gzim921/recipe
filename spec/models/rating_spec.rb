require 'rails_helper'

RSpec.describe Rating, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }

    it { should belong_to(:recipe) }
  end

  describe 'validations' do 
    it do
      should validate_numericality_of(:score)
        .with_message("shouldn't be blank and should be a number between 1 and 5")
    end

    it { should validate_uniqueness_of(:user_id).scoped_to(:recipe_id)
      .with_message('you can make one rating per recipe') }
  end
end
