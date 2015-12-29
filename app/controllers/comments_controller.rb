class CommentsController < ApplicationController
  def create
    @parent = Article.find(params[:article_id]) if params[:article_id]
    @parent = Comment.find(params[:comment_id]) if params[:comment_id]
    @comments = @parent.comments.new(comments_params)

    # pp "commenty========================================================#{@parent.comments.first.body}"
    # pp "object===================================== #{@comments.comments.count}"

    if @comments.save && request.path.include?("articles")
      redirect_to article_path(params[:article_id])
    else
      redirect_to articles_path(params[:article_id])
    end
  end

  def new
    @parent_comment = Comment.find(params[:comment_id])
    @comment = @parent_comment.comments.new(comments_params)
  end

  private
  def comments_params
    params.require(:comment).permit(:body)
  end

end
