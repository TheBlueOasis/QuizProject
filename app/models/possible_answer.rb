class PossibleAnswer < ApplicationRecord
  validates :answer, presence: true

  belongs_to :question
end

# == Schema Information
#
# Table name: possible_answers
#
#  id                :bigint           not null, primary key
#  answer            :string           not null
#  is_correct_answer :boolean          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  question_id       :bigint           not null
#
# Indexes
#
#  index_possible_answers_on_question_id  (question_id)
#
