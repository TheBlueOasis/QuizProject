class CreatePossibleAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :possible_answers do |t|
      t.string :answer, null: false
      t.boolean :is_correct_answer, null: false

      t.references :question, index: true, null: false

      t.timestamps
    end
  end
end
