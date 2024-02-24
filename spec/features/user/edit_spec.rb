require 'rails_helper'

RSpec.describe 'Editing a User', type: :system do
  let!(:user) { create :user }

  it 'changes the users password' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    click_link 'Edit Profile'
    fill_in 'user[current_password]', with: user.password
    fill_in 'user[password]', with: 'newpassword123'
    fill_in 'user[password_confirmation]', with: 'newpassword123'
    click_button 'Change'
    sleep 1 

    expect(User.count).to eq(1)
    expect(User.last.email).to eq(user.email)
    expect(User.last.encrypted_password).to be_present
  end
end
