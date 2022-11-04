class Public::QuestionsController < ApplicationController

  def index
    @users = User.all
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
      redirect_to public_user_path(current_user.id)
    else
      render:new
    end
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
    @users = User.all
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  private

  def question_params
    params.require(:question).permit(:title,:question,:game_id,:image)
  end

end
