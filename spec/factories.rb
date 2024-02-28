FactoryBot.define do 
  factory :user do 
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end   

  factory :quiz do 
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    association :user, factory: :user
  end 

  factory :question do
    name { 'Question name' }
    association :quiz, factory: :quiz
  end 

  factory :possible_answer do 
    answer { 'Possible answer' }
    is_correct_answer { true }
    association :question, factory: :question
  end   
end 

