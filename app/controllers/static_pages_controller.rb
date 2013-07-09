class StaticPagesController < ApplicationController

  def home
  	if params[:tag]
  	  @questions = Question.tagged_with(params[:tag]).paginate(page: params[:page])
  	else
  	  @questions = Question.paginate(page: params[:page])
  	end
  end

  def about
  end
end
