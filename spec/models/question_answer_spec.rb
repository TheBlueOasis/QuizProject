require 'rails_helper'

RSpec.describe QuestionAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: question_answers
#
#  id             :bigint           not null, primary key
#  answer         :string           not null
#  is_correct     :boolean          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  question_id    :bigint           not null
#  quiz_answer_id :bigint           not null
#
# Indexes
#
#  index_question_answers_on_question_id     (question_id)
#  index_question_answers_on_quiz_answer_id  (quiz_answer_id)
#
