require 'rails_helper'

RSpec.describe 'Creating a Quiz', type: :system do
  let!(:user) { create :user }

  let(:quiz_name) { 'Quiz name' }
  let(:quiz_description) { 'Quiz description' }
  let(:question_name) { 'Question name' }
  let(:answer) { 'Question Answer' }

  it 'Creates a valid Quiz' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'

    sleep 1
    visit new_quiz_path
    sleep 1
    
    fill_in 'quiz[name]', with: quiz_name
    fill_in 'quiz[description]', with: quiz_description
    fill_in 'quiz[questions_attributes][0][name]', with: question_name
    click_button 'addAnswerButton'
    fill_in 'quiz[questions_attributes][0][possible_answers_attributes][0][answer]', with: answer
    check 'quiz[questions_attributes][0][possible_answers_attributes][0][is_correct_answer]'
    click_button 'Create Quiz'
    sleep 1 

    quizzes = user.quizzes
    quiz = quizzes.last
    question = quiz.questions.last
    possible_answer = question.possible_answers.last

    expect(quizzes.count).to eq(1)
    expect(quiz.name).to eq(quiz_name) 
    expect(quiz.description).to eq(quiz_description)
    expect(quiz.questions.count).to eq(1)
    expect(question.name).to eq(question_name)
    expect(question.possible_answers.count).to eq(1)
    expect(possible_answer.answer).to eq(answer)
    expect(possible_answer.is_correct_answer).to eq(true)
  end
end
