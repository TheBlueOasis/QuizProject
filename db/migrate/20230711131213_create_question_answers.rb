class CreateQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_answers do |t|
      t.string :answer, null: false
      t.references :question, index: true, null: false
      t.references :quiz_answer, index: true, null: false

      t.boolean :is_correct, null: false

      t.timestamps
    end

    create_table :quiz_answers do |t|
      t.string :name, null: false
      t.references :quiz, index: true, null: false

      t.decimal :score, precision: 3, scale: 2, null: false

      t.timestamps
    end
  end
end
