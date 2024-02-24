Rails.application.routes.draw do
  devise_for :users
  root "main#main"

  get "/all_quizzes", to: "quizzes#all_quizzes"

  resources :quizzes, :except => [:index]
  get "/quizzes", to: "quizzes#my_quizzes"
  
  get "/quizzes/:id/take", to: "quizzes#take_quiz", as: :take_quiz
  post "quizzes/complete", to: "quizzes#complete"

  get "completed", to: "quizzes#completed_quizzes", as: :completed_quizzes
  get "completed/:id", to: "quizzes#completed_quiz", as: :completed_quiz
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
