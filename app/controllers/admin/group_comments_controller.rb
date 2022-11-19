class Admin::GroupCommentsController < ApplicationController

  def destroy
    GroupComment.find(params[:id]).destroy
    @group = Group.find(params[:group_id])
    redirect_to admin_group_path(@group.id)
  end

  private

  def group_comment_params
    params.require(:group_comment).permit(:group_comment)
  end

end
