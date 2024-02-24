module DifficultyHelper
  def quiz_difficulty(quiz)
    avg_score = avg_score(quiz)
    if avg_score != 'none'
      avg_score = avg_score(quiz)[0...-1].to_i
    else
      avg_score = avg_score(quiz)
    end 
    case avg_score
    when  'none'
      'TBD'
    when 0..25
      'Impossible'
    when 25..50
      'Hard'
    when 50..75
      'Medium'
    when 75..100
      'Easy'
    else 
      'Error: invalid average score'
    end 
  end 

  def difficulty_color(quiz)
    difficulty = quiz_difficulty(quiz)
    case difficulty
    when  'Impossible'
      'text-red'
    when  'Hard'
      'text-orange'
    when 'Medium'
      'text-yellow'
    when  'Easy'
      'text-green'
    end
  end
end
