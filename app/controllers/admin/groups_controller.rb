class Admin::GroupsController < ApplicationController

  def index
    @question = Question.new
    @groups = Group.all.order("id DESC").page(params[:page]).per(20)
    # @groups = Group.order("id DESC")
    @group = Group.new
  end

  def show
    @question = Question.all
    @group = Group.find(params[:id])
    @group_comment = GroupComment.new
    @group_comment = GroupComment.all
    @group_comments = @group.group_comments
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to public_group_path(@group.id)
    else
      render "edit"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.users.delete(current_user)
    redirect_to admin_groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end


end
