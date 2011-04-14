class SessionsController < ApplicationController
  def new
    @title = "Sign in"
    if signed_in?
      redirect_to root_path
    end
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid combination of e-mail and password"
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      flash[:success] = "You're logged in as #{ current_user.name }"
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    flash[:notice] = "Thanks for stopping by, see you soon!"
    redirect_to root_path
  end

end
