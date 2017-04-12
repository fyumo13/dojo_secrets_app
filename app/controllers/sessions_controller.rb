class SessionsController < ApplicationController
    skip_before_action :require_login, except: [:destroy]
    
    # logs user into account
    def create
      @user = User.find_by_email(params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to "/users/#{@user.id}"
      else
        flash[:errors] = ["Invalid email/pasword combination"]
        redirect_to "/sessions/new"
      end
    end

    # logs user out of account
    def destroy
      session[:user_id] = nil
      redirect_to "/sessions/new"
    end
end
