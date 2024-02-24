class QuizzesController < ApplicationController
  before_action :authenticate_user!, except: [:all_quizzes, :take_quiz, :complete, :completed_quiz ]

  def index
  end

  def my_quizzes
    @quizzes = Quiz.where(user: current_user)
  end

  def all_quizzes
    @quizzes = Quiz.all
  end 

  def new
    @quiz = Quiz.new
    @quiz.questions.build
  end

  def show
    if Quiz.exists?(id: params[:id])
      @quiz = Quiz.find(params[:id])
    else
      flash[:alert] = "Quiz does not exist!"
      redirect_to quizzes_path
    end
  end

  def destroy
    quiz = Quiz.find(params[:id])
    quiz.destroy!
    flash[:notice] = "Quiz deleted successfully!"
    redirect_to quizzes_path
  end

  def edit
    if Quiz.exists?(id: params[:id])
      @quiz = Quiz.find(params[:id])
      render :edit, locals: { quiz: @quiz }
    else
      flash[:alert] = "Quiz does not exist!"
      redirect_to quizzes_path
    end
  end

  def update
    quiz = Quiz.find(params[:id])

    begin
      Quiz.transaction do 
        quiz.update!(quiz_params)
        if quiz.valid?
          flash[:notice] = "Quiz updated successfully"
          redirect_to quiz_path(id: params[:id])
        else
          flash[:alert] = quiz.errors.full_messages.to_sentence
          redirect_to edit_quiz_path
          raise ActiveRecord::Rollback
        end 
      end
    rescue => exception
      flash[:alert] = quiz.errors.full_messages.to_sentence
      redirect_to edit_quiz_path
    end
  end

  def create
    quiz = Quiz.new(quiz_params)
    begin
      if quiz.save!
        flash[:notice] = "Quiz added successfully!"
        redirect_to quizzes_path
      end
    rescue => exception
      flash[:alert] = quiz.errors.full_messages.to_sentence
      redirect_to new_quiz_path
    end
  end
  

  def take_quiz
    if Quiz.exists?(id: params[:id])
      @quiz = Quiz.where(id: params[:id])
      @quiz_answer = QuizAnswer.new
      @quiz_answer.question_answers.build
    else
      flash[:alert] = "Quiz does not exist!"
      redirect_to quizzes_path
    end
  end 

  def complete
    quiz_answer = QuizAnswer.new(quiz_answer_params)

    QuizAnswerService.new(quiz_answer).update_score

    if quiz_answer.save!
      flash[:notice] = "Quiz completed successfully!"
    else 
      flash[:alert] = quiz_answer.errors.full_messages.to_sentence
    end 
    redirect_to completed_quiz_path(quiz_answer.id)
  end

  def completed_quizzes
    @my_answers = QuizAnswer.where(name: current_user.email)
  end

  def completed_quiz
    @my_answer = QuizAnswer.where(id: params[:id])
  end 

  private 

  def quiz_params
    params.require(:quiz).permit(
      :id,
      :created_by_id,
      :name,
      :description,
      questions_attributes: [
        :id,
        :_destroy,
        :name,
        possible_answers_attributes: [
          :id,
          :answer,
          :is_correct_answer,
          :_destroy
        ] 
      ]
    )
  end
  
  def quiz_answer_params
    params.require(:quiz_answer).permit(
      :name,
      :quiz_id,
      question_answers_attributes: [
        :answer,
        :question_id,
        :quiz_answer_id
      ]
    )
  end  
end 
