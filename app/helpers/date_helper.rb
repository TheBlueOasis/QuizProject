module DateHelper
  def created_ago(start_date, end_date)
    distance_of_time_in_words(start_date, end_date)
  end
end 
