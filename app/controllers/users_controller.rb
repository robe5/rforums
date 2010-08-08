class UsersController < ApplicationController
  layout 'users'
  before_filter :sign_in_required, :only => [:edit, :update]
  before_filter :require_right_user, :only => [:edit, :update]
  
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    params[:user].except!(:password, :password_confirmation) if params[:user][:password].blank?
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end
  
  private
  def require_right_user
    if current_user.id.to_s != params[:id]
      flash[:error] = "You cannot edit this user"
      redirect_to :action => :show, :id => params[:id]
    end
  end
end