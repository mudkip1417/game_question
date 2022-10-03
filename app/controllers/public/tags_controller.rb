class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tags = Tag.find(params[:id])
  end

  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to public_tags_path
  end
end
