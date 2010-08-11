class SessionsController < ApplicationController
  layout 'users'
  
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:success] = "Login successful"
      self.current_user = @user
      redirect_to root_path
    else
      flash[:error] = "Login failed"
      redirect_to users_path
    end
  end
  
  def recovery
    @user = User.first(:conditions => {:reset_password_code => params[:token], :reset_password_code_until.gte => Time.now})
    if @user
      self.current_user = @user
      flash[:success] = "Please change your password"
      redirect_to edit_user_path(@user)
    else
      flash[:error] = "Token not valid"
      redirect_to root_path
    end
  end
    
  def destroy
    self.current_user = nil
    flash[:success] = "Logout successful"
    redirect_to root_path
  end
end