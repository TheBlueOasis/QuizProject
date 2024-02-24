class AddCreatedByToQuizzes < ActiveRecord::Migration[7.0]
  def change
    add_reference :quizzes, :created_by, index: true, foreign_key: { to_table: :users }
  end
end
