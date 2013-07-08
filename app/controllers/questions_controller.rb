class QuestionsController < ApplicationController
  before_filter :signed_in_user

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      flash[:success] = "Question posted!"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
  end
end