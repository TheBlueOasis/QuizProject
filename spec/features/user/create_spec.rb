require 'rails_helper'

RSpec.describe 'Creating a User', type: :system do
  it 'creates a valid user' do
    visit new_user_registration_path
    fill_in 'user[email]', with: 'bob@email.com'
    fill_in 'user[password]', with: 'bob1234'
    fill_in 'user[password_confirmation]', with: 'bob1234'
    click_button 'Sign up'
    sleep 1

    expect(User.count).to eq(1)
    expect(User.last.email).to eq('bob@email.com')
  end
end
