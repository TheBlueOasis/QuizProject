require 'rails_helper'

RSpec.describe Quiz, type: :system do
  let!(:user) { create :user }
  let!(:quiz) do
    quiz = build(:quiz, user: user)
    quiz.save(validate: false)
    quiz
  end
  let!(:question) { create :question, quiz: quiz }
  let!(:possible_answer) { create :possible_answer, question: question }
  
  it 'is a valid quiz' do 
    expect(quiz).to be_valid
  end 

  it 'is not a valid quiz if name is not provided' do
    quiz.name = nil
    expect(quiz).not_to be_valid
  end

  it 'is not a valid quiz if description is not provided' do
    quiz.description = nil
    expect(quiz).not_to be_valid
  end

  it 'is not a valid quiz if there is no question' do
    quiz.questions = [] 
    expect(quiz).not_to be_valid
  end 

  it 'is not a valid quiz if there is no answer' do 
    question.possible_answers = []
    expect(quiz).not_to be_valid
  end 
end 
