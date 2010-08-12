class TopicsController < ApplicationController
  before_filter :find_category
  before_filter :sign_in_required, :only => [:new, :create]
  before_filter :admin_required, :only => [:edit, :update, :destroy]
  
  def index
    redirect_to @category
  end
  
  def show
    @topic = @category.topics.find!(params[:id])
    @posts = @topic.posts.paginate(:per_page => 10, :page => params[:page])
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    params[:topic].merge!(:category => @category, :user => current_user)
    @topic = Topic.new(params[:topic])

    if @topic.save
      flash[:success] = "Topic #{@topic.title} created"
      redirect_to @topic.category
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      render :action => 'new'
    end
  end
  
  def edit
    @topic = @category.topics.find!(params[:id])
  end
  
  def update
    @topic = @category.topics.find!(params[:id])

    if @topic.update_attributes(params[:topic])
      flash[:success] = "Topic #{@topic.title} updated"
      redirect_to [@category, @topic]
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      render :action => 'edit'
    end
  end
  
  def destroy
    @topic = @category.topics.find!(params[:id])
    
    @topic.destroy
    flash[:success] = "Topic #{@topic.title} deleted"
    
    redirect_to @category
  end
  
  private
  def find_category
    @category = Category.find!(params[:category_id])
  end
end