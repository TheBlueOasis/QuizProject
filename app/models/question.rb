class Question < ApplicationRecord
  validates :name, presence: true

  has_many :question_answers, dependent: :destroy
  has_many :possible_answers, dependent: :destroy

  belongs_to :quiz

  accepts_nested_attributes_for :possible_answers, reject_if: :all_blank, allow_destroy: true
end

# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#
# Indexes
#
#  index_questions_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
