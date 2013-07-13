class StaticPagesController < ApplicationController

  def home
  	if params[:tag]
  	  @questions = Question.tagged_with(params[:tag]).paginate(page: params[:page])
      @users = []
  	else
  	  @questions = Question.paginate(page: params[:page])
  	  @users = User.paginate(page: params[:page]).most_reputation
  	end
  end

  def about
  end
end
