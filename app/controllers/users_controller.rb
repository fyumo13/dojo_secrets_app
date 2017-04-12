class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show, :edit, :update, :destroy]
  before_action :require_id_match, except: [:index, :new, :create]

  # registers new user account
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/sessions/new"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  # displays page with user info and personal secrets
  def show
    @user = User.find(params[:id])
    @secrets = Secret.where(user:@user)
    @secrets_liked = @user.secrets_liked
  end

  # displays page that allows user to edit information
  def edit
    @user = User.find(params[:id])
  end

  # updates user information
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
    end
  end

  # deletes user account
  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to "/users/new"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def require_id_match
      if current_user != User.find(params[:id])
        redirect_to "/users/#{session[:user_id]}"
      end
    end
end
