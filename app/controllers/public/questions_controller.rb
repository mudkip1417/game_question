class Public::QuestionsController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @questions = Question.all.order("id DESC").page(params[:page]).per(20)
    # @questions = Question.order("id DESC").page(params[:page]).per(20)
    @tag_list = Tag.find(Tagmap.group(:tag_id).order('count(question_id) desc').limit(22).pluck(:tag_id))
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
      redirect_to public_question_path(@question.id)
    else
      render:new
    end
  end

  def show
    @question = Question.find(params[:id])
    @tag_list = @question.tags
    @comment = Comment.new
    @comment = Comment.all
    @comments = @question.comments
  end

  def edit
    @question = Question.find(params[:id])
    @tag_list = @question.tags.pluck(:tag_name).join(',')
  end

  def update
    @question = Question.find(params[:id])
    @tag_list = params[:question][:tag_name].split(',')
    if @question.update(question_params)
      @old_relations = Tagmap.where(question_id: @question.id)
      @old_relations.each do |relation|
        relation.delete
      end
      @question.save_tag(@tag_list)
      redirect_to public_question_path(@question.id)
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to public_user_path(current_user.id)
  end

  def search_tag
    @tag_list = Tag.find(Tagmap.group(:tag_id).order('count(question_id) desc').limit(22).pluck(:tag_id))
    @tag = Tag.find(params[:tag_id])
    @questions = @tag.questions.order("id DESC").page(params[:page]).per(20)
    @users = User.all
  end

  def bookmark
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @bookmarks = Bookmark.order("id DESC").page(params[:page]).per(20)
  end

  def correct_user
    @question = Question.find(params[:id])
    @user = @question.user
    redirect_to(public_questions_path) unless @user == current_user
  end


  private

  def question_params
    params.require(:question).permit(:title,:question,:game_id,:image, question_images: [])
  end

end
