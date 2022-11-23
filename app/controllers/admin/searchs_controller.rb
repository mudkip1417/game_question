class Admin::SearchsController < ApplicationController
  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word]).order("id DESC").page(params[:page]).per(20)
    elsif @range == "Question"
      @questions = Question.looks(params[:search], params[:word]).order("id DESC").page(params[:page]).per(20)
    else
      @tag_list = Tag.looks(params[:search], params[:word]).order("id DESC").page(params[:page]).per(100)
    end
  end
end
