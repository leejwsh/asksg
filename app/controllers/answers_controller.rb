class AnswersController < ApplicationController
  before_filter :signed_in_user

  def create
  	@question = Question.find(params[:answer][:question_id])
  	@answer = @question.answers.build(content: params[:answer][:content])
  	@answer.user = current_user
    if @answer.save
      flash[:success] = "Answer posted!"
      redirect_to question_path(@question)
    else
       @answers = @question.answers.paginate(page: params[:page])
       render "questions/show"
    end
  end

  def destroy
  end
end