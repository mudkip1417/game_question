class Public::CommentsController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @comment = current_user.comments.new(comment_params)
    @comment.question_id = @question.id
    if @comment.save
      redirect_to public_question_path(@question.id)
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy!
    @question = Question.find(params[:question_id])
    redirect_to public_question_path(@question.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
