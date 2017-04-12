class LikesController < ApplicationController
  # likes a secret
  def create
    Like.create(secret_id: params[:secret], user: current_user)
    redirect_to "/secrets"
  end

  # dislikes a secret
  def destroy
    @like = Like.find(params[:id])
    if current_user == @like.user
      @like.destroy
    end
    redirect_to "/secrets"
  end
end
