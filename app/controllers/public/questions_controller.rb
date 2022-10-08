class Public::QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @tag_list = Tag.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    tag_list = params[:question][:tag_name].split(',')
    if @question.save
      @question.save_tag(tag_list)
      # binding.pry
      redirect_to public_questions_path
    else
      render:new
    end
  end

  def show
    @question = Question.find(params[:id])
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
    @tag_list = tag.all
    @tag = Tag.find(params[:tag_id])
    @questions = @tag.questions
  end

  private

  def question_params
    params.require(:question).permit(:title,:question,:game_id,:image)
  end

end
