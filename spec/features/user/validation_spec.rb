require 'rails_helper'

RSpec.describe User, type: :system do
  let (:gmail) { 'bob@gmail.com' }
  let!(:user) { create :user, email: gmail }

  it 'is valid with valid username/password' do
    expect(user).to be_valid
  end 

  it 'has a unique email' do
    user2 = build(:user, email: gmail)
    expect(user2).not_to be_valid
  end

  it 'is not valid without an email' do 
    user2 = build(:user, email: nil)
    expect(user2).not_to be_valid
  end

  it 'is not valid without a password' do 
    user2 = build(:user, password: nil)
    expect(user2).not_to be_valid
  end
end
