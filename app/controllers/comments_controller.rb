class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to protospace_id(@comment.protospace)
    else
      @protospace = @comment.protospace
      @comments = @protospace.comments
      render "protospaces/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, protospace_id: params[:protospace_id])
  end
end
