require 'rails_helper'

RSpec.describe User do
  before :each do
    User.create!(
      email: 'test@test.com',
      password: 'pw', 
      password_confirmation: 'pw'
    )
  end

  describe 'Relationships' do
    it { should have_many(:api_keys) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
  end
end
