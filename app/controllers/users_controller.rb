class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(allowed_parameters)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      flash.now[:error] = 'Are you having deja vu? We are. Did you forget your password?' if User.find_by_email(params[:user][:email])
      flash.now[:error] = 'Oops, your password and password confirmation don\'t match' if params[:user][:password] != params[:user][:password_confirmation]
      render :new
    end
  end

  def allowed_parameters
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
