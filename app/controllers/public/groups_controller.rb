class Public::GroupsController < ApplicationController
  def index
    @question = Question.new
    @groups = Group.all
    @group = Group.new
  end

  def show
    @question = Question.all
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to public_groups_path
    else
      render 'new'
    end
    # binding.pry
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to public_groups_path
    else
      render "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name,:introduction,:image)
  end


end
