class TopicsController < ApplicationController
  before_filter :find_category
  
  def index
    redirect_to @category
  end
  
  def show
    @topic = @category.topics.find(params[:id])
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(params[:topic])

    @topic.user = current_user
    @category.topics << @topic
    
    if @category.save
      redirect_to @category
    else
      render :action => 'new'
    end
  end
  
  private
  def find_category
    @category = Category.find(params[:category_id])
  end
end