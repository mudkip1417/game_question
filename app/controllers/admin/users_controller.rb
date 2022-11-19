class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order("id DESC").page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @questions = @user.questions.order("id DESC").page(params[:page]).per(20)
    @tag_list = Tag.all
    @tag_list = Tag.order("id DESC")
    @question = Question.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to public_user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :profile_image,:password, :introduction, :email, :telephone_number, :favorite_game, :title, :question, :image)
  end

end
