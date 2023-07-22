class PrototypesController < ApplicationController
  before_action :move_to_login, except: [:index, :show]

  def index
    @prototype = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
    render :new, status: :unprocessable_entity
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    move_to_index
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  
  
  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_login
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def move_to_index
    unless user_signed_in? && current_user.id == @prototype.user_id
    redirect_to action: :index
    end
  end
end
