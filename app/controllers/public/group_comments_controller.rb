class Public::GroupCommentsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_comment = current_user.group_comments.new(group_comment_params)
    @group_comment.group_id = @group.id
    if @group_comment.save
      redirect_to public_group_path(@group.id)
    end
  end

  def destroy
    GroupComment.find(params[:id]).destroy
    @group = Group.find(params[:group_id])
    redirect_to public_group_path(@group.id)
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:group_comment)
  end

end
