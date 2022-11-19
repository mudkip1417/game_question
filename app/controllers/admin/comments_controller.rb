class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find(params[:id]).destroy
    @question = Question.find(params[:question_id])
    redirect_to admin_question_path(@question.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
