class QuizAnswer < ApplicationRecord
  has_many :question_answers, dependent: :destroy

  belongs_to :quiz
  accepts_nested_attributes_for :question_answers
end

# == Schema Information
#
# Table name: quiz_answers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  score      :decimal(3, 2)    not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#
# Indexes
#
#  index_quiz_answers_on_quiz_id  (quiz_id)
#
