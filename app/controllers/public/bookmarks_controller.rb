class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    bookmark = @question.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    bookmark = @question.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

end
