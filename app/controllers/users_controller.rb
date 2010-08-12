class UsersController < ApplicationController
  layout 'application'
  before_filter :sign_in_required, :only => [:edit, :update]
  before_filter :require_right_user, :only => [:edit, :update]

  def index
    if params[:query]
      conditions = {:conditions => {:name => /#{params[:query]}/i}}
    else
      conditions = {}
    end
    @users = User.all(conditions)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
    render :layout => 'users'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user = @user
      Notifications.new_user(@user).deliver
      flash[:success] = "Welcome to Forums Community"
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
    params[:user].except!(:admin) unless admin? or params[:user].nil?
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def help
    render :layout => 'users'
  end
  
  def recover
    @user = User.first(:conditions => {:email => params[:email]})

    if @user
      @user.set_password_code!
      Notifications.password_recovery(@user).deliver
      flash[:success] = "Please check your email"
      redirect_to root_path
    else
      flash[:error] = "Your account could not be found"
      redirect_to help_user_path
    end
  end
    
  private
  def require_right_user
    if !admin? && current_user.id.to_s != params[:id]
      flash[:error] = "You cannot edit this user"
      redirect_to :action => :show, :id => params[:id]
    end
  end
end
