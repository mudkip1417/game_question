class Admin::QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @tag_list = Tag.all
  end

  def show
    @question = Question.find(params[:id])
    @comment = Comment.new
    @comment = Comment.all
    @comments = @question.comments
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to public_questions_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @questions = @tag.questions
  end

  private

  def question_params
    params.require(:question).permit(:title,:question,:game_id,:image)
  end


end
