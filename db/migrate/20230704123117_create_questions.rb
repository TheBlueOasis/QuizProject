class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.string :correct_answer, null: false
      t.references :quiz, index: true, null: false, foreign_key: true

      t.timestamps
    end
  end
end
