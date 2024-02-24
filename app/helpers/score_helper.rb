module ScoreHelper
  def avg_score(quiz)
    total = 0.0
    q_count = quiz.quiz_answers.count
    quiz.quiz_answers.each do |qa|
      total += qa.score
    end 
    result = total / q_count
    if result.nan?
      "none"
    else
      format_score(result)
    end 
  end

  def question_stats(question)  
    answer_count = question.question_answers.count
    correct_answers = 0.0
    question.question_answers.each do |question_answer|
      correct_answers += 1 if question_answer.is_correct
    end 
    return format_score(correct_answers / answer_count) if answer_count > 0
    'none'
  end

  def correct_out_of_total(quiz_answer)
    total = quiz_answer.question_answers.count
    correct = 0
    quiz_answer.question_answers.each do |question_answer|
      correct += 1 if question_answer.is_correct
    end
    "#{correct}/#{total}"
  end 

  def question_difficulty_color(question)
    score = question_stats(question)
    if score[0...-1].to_i >= 65
      'text-green'
    else
      'text-red'
    end 
  end

  def is_correct_color(question_answer)
    if question_answer.is_correct
      return 'text-green'
    end
    'text-red'
  end 

  def is_correct_number(question_answer)
    if question_answer.is_correct
      return 1
    end 
    0
  end 

  def passing_rate(quiz)
    passes = 0.0
    answer_count = quiz.quiz_answers.count
    quiz.quiz_answers.each do |quiz_answer|
      if quiz_answer.score >= 0.65 
        passes += 1
      end
    end
    if answer_count > 0 
      return (passes / answer_count).round(2)
    end
    0
  end 

  def format_score(num)
    "#{(num * 100).round(1)}%"
  end

  def attempt_color(quiz_answer)
    if quiz_answer.score >= 0.65
      "text-green"
    else
      "text-red"
    end
  end

  def avg_color(quiz)
    avg = avg_score(quiz)
    if avg[0...-1].to_i >= 65
      "text-green"
    else
      "text-red"
    end 
  end 
end
