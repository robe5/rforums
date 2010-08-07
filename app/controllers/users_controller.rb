class UsersController < ApplicationController
  layout 'users'
  before_filter :sign_in_required, :only => [ :show ]
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      redirect_to root_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Usuario actualizado"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end
end