class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    sort = params[:sort]
    @microposts = Micropost.all.order(sort)
    @comment = @micropost.comments.create(params[:comment])
    redirect_to micropost_path(@micropost)
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    redirect_to micropost_path(@micropost)
  end

  private

    def comment_params
      params.require(:comment).permit(:name, :body)
    end
end