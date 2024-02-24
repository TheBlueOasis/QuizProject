require 'rails_helper'

RSpec.describe PossibleAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
