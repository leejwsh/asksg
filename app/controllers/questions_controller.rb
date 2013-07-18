class QuestionsController < ApplicationController
  before_filter :signed_in_user,   only: [:new, :create, :destroy, :vote]
  before_filter :not_own_question, only: [:vote]
  before_filter :correct_user,     only: [:destroy]

  def index
    @questions = Question.paginate(page: params[:page]).search(params[:search])
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      flash[:success] = "Question posted!"
      redirect_to question_path(@question)
    else
      render 'new'
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.paginate(page: params[:page]).most_voted
    @answer = @question.answers.build if signed_in?
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to root_url
  end

  def vote
    value = params[:type] == "up" ? 1 : -1

    # Undo question vote.
    eval = @question.evaluations.where(reputation_name: :votes,
                                       source_id: current_user.id,
                                       target_id: @question.id).first
    if (eval.present? && eval.value == value)
      @question.delete_evaluation(:votes, current_user)
      redirect_to :back, notice: "Vote retracted"
    else
      @question.add_or_update_evaluation(:votes, value, current_user)
      redirect_to :back, notice: "Thank you for voting"
    end
  end

  private

    def not_own_question
      @question = Question.find(params[:id])
      redirect_to(root_path) if current_user?(@question.user)
    end

    def correct_user
      @question = current_user.questions.find_by_id(params[:id])
      redirect_to root_url if @question.nil?
    end
end