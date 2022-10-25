class Public::UsersController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @question = Question.all
    @questions = @user.questions
    @tag_list = Tag.all
  end

  def show
    @user = User.find(current_user.id)
    @user = User.all
  end

  def edit
  end

  def unsubscribe
  end

end
