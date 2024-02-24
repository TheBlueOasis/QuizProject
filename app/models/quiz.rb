class Quiz < ActiveRecord::Base
  validates :name, :description, presence: true

  belongs_to :user, foreign_key: "created_by_id"

  has_many :questions, autosave: true, dependent: :destroy
  has_many :quiz_answers, dependent: :destroy
  
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  validate :has_questions, :has_answers, :has_correct_answers, on: [:update, :create]

  def has_questions
    if questions.empty?
      errors.add(:base, "A Quiz must have at least one question")
    end 
  end  

  def has_answers
    questions.each do |question|
      if question.possible_answers.empty?
        errors.add(:base, "Question '#{question.name}' must have at least one answer")
      end
    end 
  end 

  def has_correct_answers
    questions.each do |question|
      if question.possible_answers.none?(&:is_correct_answer?)
        errors.add(:base, "Question '#{question.name}' must have at least one correct answer")
      end
    end
  end 
end

# == Schema Information
#
# Table name: quizzes
#
#  id            :bigint           not null, primary key
#  description   :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  created_by_id :bigint
#
# Indexes
#
#  index_quizzes_on_created_by_id  (created_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#
