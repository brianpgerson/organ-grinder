class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login!(@user)
      flash[:notice] = "Congrats on loggin' on in, #{@user.username}!"
      redirect_to posts_url
    else
      flash[:errors] = "Invalid login, partner"
      @user = User.new(username: user_params[:username])
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to posts_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
