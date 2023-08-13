class ProtospacesController < ApplicationController
  before_action :set_protospace, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index
    @protospaces = Protospace.includes(:user)
  end

  def new
    @protospace = Protospace.new
  end

  def create
    @protospace = Protospace.new(protospace_params)
    if @protospace.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @protospace.comments
  end

  def edit
  end

  def update
    if @protospace.update(protospace_params)
      redirect_to protospace_path(@protospace)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @protospace.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def protospace_params
    params.require(:protospace).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_protospace
    @protospace = Protospace.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @protospace.user
  end
end
