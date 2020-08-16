require 'rails_helper'

RSpec.describe User do
  context 'before saving' do
    it 'transforms email to lower case' do
      gzim = create(:user, email: 'TESTER@TEST.COM')

      expect(gzim.email).to eq 'tester@test.com'
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes) }
    it { is_expected.to have_many(:ratings) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:user_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to have_secure_password }

    it { is_expected.to validate_length_of(:first_name).is_at_most(255) }
    it { is_expected.to validate_length_of(:last_name).is_at_most(255) }

    it { is_expected.to validate_length_of(:email).is_at_most(50) }

    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  context 'email must be unique' do
    subject { create(:user) }

    it { is_expected.to validate_uniqueness_of(:email) }
  end

  context 'when entering invalid email format' do
    it 'is invalid' do
      gzim = build(:user, email: 'gziminvalid')

      expect(gzim.valid?).to be false
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:recipes) }
  end

  describe 'dependency' do
    let(:count) { 1 }
    let(:user) { create(:user) }

    it 'deletes recipes when user is deleted' do
      create_list(:recipe, count, user: user)

      expect { user.destroy }.to change { Recipe.count }.by(0)
    end
  end
end
