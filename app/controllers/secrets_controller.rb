class SecretsController < ApplicationController
  # displays page with all user secrets
  def index
    @secrets = Secret.all
  end

  # creates an anonymous secret
  def create
    @user = User.find(session[:user_id])
    @secret = Secret.new(content:params[:content], user:@user)
    if !@secret.save
      flash[:notice] = @secret.errors.full_messages
    end
    redirect_to "/users/#{@user.id}"
  end

  # deletes a secret linked to a given user
  def destroy
    @secret = Secret.find(params[:id])
    if current_user == @secret.user
      @secret.destroy
    end
    redirect_to "/users/#{session[:user_id]}"
  end
end
