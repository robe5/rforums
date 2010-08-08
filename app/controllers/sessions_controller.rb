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
    
  def destroy
    self.current_user = nil
    redirect_to root_path
  end
end