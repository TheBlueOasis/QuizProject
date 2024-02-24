module CorrectAnswerHelper
  def correct_answer(possible_answers)
    correct_answers = possible_answers.select { |possible_answer| possible_answer.is_correct_answer }
    if correct_answers.empty?
      "there are no correct answers"
    elsif correct_answers.length == 1
      correct_answers[0].answer
    else
      correct_answers.map(&:answer).join(" or ")
    end
  end
end
