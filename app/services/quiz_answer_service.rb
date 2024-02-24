class QuizAnswerService
  def initialize(quiz_answer)
    @quiz_answer = quiz_answer
  end

  def update_score
    correct_answer_count = 0.0
    correct_answers = []

    # Check and update each question's correctness and count how many were correct
    @quiz_answer.question_answers.each do |question_answer|
      question_answer.question.possible_answers.each do |possible_answer|
        if possible_answer.is_correct_answer
          correct_answers.append(possible_answer.answer)
          if possible_answer.answer == question_answer.answer
            correct_answer_count += 1
          end 
        end
      end
      if correct_answers.include? question_answer.answer
        question_answer.is_correct = true
      else
        question_answer.is_correct = false 
      end
    end

    @quiz_answer.score = correct_answer_count / @quiz_answer.question_answers.each.count
  end 
end
