class Public::SearchesController < ApplicationController

  # def search
  #   @model = params["model"]
  #   @content = params["content"]
  #   @method = params["method"]
  #   @records = search_for(@model, @content, @method)
  # end

  # private
  # def search_for(model, content, method)
  #   if model == 'User'
  #     if method == 'perfect'
  #       User.where(name: content)
  #     else
  #       User.where('name LIKE ?', '%'+content+'%')
  #     end
  #   elsif model == 'Question'
  #     if method == 'perfect'
  #       Post.where(title: content)
  #     else
  #       Post.where('title LIKE ?', '%'+content+'%')
  #     end
  #   end
  # end

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      @users = User.order("id DESC")
    else
      @questions = Question.looks(params[:search], params[:word])
      @questions = Question.order("id DESC")
    end
  end

end
