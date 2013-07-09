class StaticPagesController < ApplicationController

  def home
    @questions = Question.paginate(page: params[:page])
  end

  def about
  end
end
