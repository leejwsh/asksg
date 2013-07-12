class AnswersController < ApplicationController
  before_filter :signed_in_user
  before_filter :not_own_answer, only: [:vote]

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

  def vote
    value = params[:type] == "up" ? 1 : -1
    @answer = Answer.find(params[:id])

    # Undo answer vote.
    eval = @answer.evaluations.where(reputation_name: :votes,
                                     target_id: @answer.id).first
    value = 0 if eval.value == value

    @answer.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end

  private

    def not_own_answer
      @answer = Answer.find(params[:id])
      redirect_to(root_path) if current_user?(@answer.user)
    end
end