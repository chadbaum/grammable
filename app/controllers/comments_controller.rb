class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create

    @gram = Gram.find_by_id(params[:gram_id])
    return render_not_found if @gram.blank?

    @comment = @gram.comments.create(comment_params)
    if @comment.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:message)
  end

end
