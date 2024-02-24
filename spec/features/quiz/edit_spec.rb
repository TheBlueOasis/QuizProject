require 'rails_helper'

RSpec.describe 'Editing a Quiz', type: :system do
  let!(:user) { create :user }
  let!(:quiz) do
    quiz = build(:quiz, user: user)
    quiz.save(validate: false)
    quiz
  end
  let!(:question) { create :question, quiz: quiz }
  let!(:possible_answer) { create :possible_answer, question: question }

  let!(:new_name) { Faker::Lorem.word }
  let!(:new_description) { Faker::Lorem.sentence }
  let!(:new_question_name) { Faker::Lorem.word }
  let!(:new_question_answer) { Faker::Lorem.word }

  it 'Edits a Quiz validly' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
    sleep 1
    visit quiz_path(quiz.id)
    sleep 1
    click_button 'Edit'

    fill_in 'quiz[name]', with: new_name
    fill_in 'quiz[description]', with: new_description
    fill_in 'quiz[questions_attributes][0][name]', with: new_question_name
    fill_in 'quiz[questions_attributes][0][possible_answers_attributes][0][answer]', with: new_question_answer
    click_button 'Update Quiz'
    sleep 1

    quiz = Quiz.last 
    question = quiz.questions.last
    possible_answer = question.possible_answers.last

    expect(quiz.name).to eq(new_name)
    expect(quiz.description).to eq(new_description)
    expect(question.name).to eq(new_question_name)
    expect(possible_answer.answer).to eq(new_question_answer)
  end 
end 
