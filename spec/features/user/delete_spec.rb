require 'rails_helper'

RSpec.describe 'Deleting a User', type: :system do
  let!(:user) { create :user }

  it 'deletes a user' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    click_link 'Edit Profile'
    click_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    sleep 1 

    expect(User.count).to eq(0)
  end
end
