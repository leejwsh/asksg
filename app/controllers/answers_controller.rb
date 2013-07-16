class AnswersController < ApplicationController
  before_filter :signed_in_user
  before_filter :not_own_answer, only: [:vote]
  before_filter :correct_user,   only: [:destroy]

  def create
  	@question = Question.find(params[:answer][:question_id])
  	@answer = @question.answers.build(content: params[:answer][:content])
  	@answer.user = current_user
    if @answer.save
      flash[:success] = "Answer posted!"
      redirect_to question_path(@question)
    else
      @answers = @question.answers.paginate(page: params[:page]).most_voted
      render "questions/show"
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = "Answer deleted!"
    redirect_to question_path(@answer.question)
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @answer = Answer.find(params[:id])

    # Undo answer vote.
    eval = @answer.evaluations.where(reputation_name: :votes,
                                     source_id: current_user.id,
                                     target_id: @answer.id).first
    value = 0 if (eval.present? && eval.value == value)

    @answer.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end

  private

    def not_own_answer
      @answer = Answer.find(params[:id])
      redirect_to(root_path) if current_user?(@answer.user)
    end

    def correct_user
      @answer = current_user.answers.find_by_id(params[:id])
      redirect_to root_url if @answer.nil?
    end
end