class QuestionsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy]

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
    @answers = @question.answers.paginate(page: params[:page])
    @answer = @question.answers.build if signed_in?
  end

  def destroy
  end
end