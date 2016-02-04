class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      flash[:notice] = "Congrats on loggin' on in, #{@user.username}!"
      redirect_to posts_url
    else
      flash[:errors] = @user.errors.full_messages
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
