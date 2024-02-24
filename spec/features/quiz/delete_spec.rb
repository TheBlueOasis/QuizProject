require 'rails_helper'

RSpec.describe 'Deleting a Quiz', type: :system do
  let!(:user) { create :user }
  let!(:quiz) do
    quiz = build(:quiz, user: user)
    quiz.save(validate: false)
    quiz
  end

  it 'Deletes a Quiz' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    
    sleep 1
    visit quiz_path(quiz.id)
    sleep 1

    expect(User.last.quizzes.count).to eq(1)
    expect(Quiz.all.count).to eq(1)

    click_button 'Delete'
    page.driver.browser.switch_to.alert.accept
    sleep 1

    expect(User.last.quizzes.count).to eq(0)
    expect(Quiz.all.count).to eq(0)
  end 
end 
