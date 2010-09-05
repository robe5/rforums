class PostsController < ApplicationController
  before_filter :find_topic
  before_filter :sign_in_required, :only => [:create]
  before_filter :admin_required, :only => [:edit, :update, :destroy]  
  
  def create
    params[:post].merge!(:topic => @topic, :user => current_user)
    @post = Post.new(params[:post])
    
    if @post.save
      flash[:success] = "Post created"

      redirect_to category_topic_path(@category, @topic, :anchor => "post-#{@post.id}")
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      redirect_to category_topic_path(@category, @topic, :anchor => 'reply')
    end
  end

  def edit
    @post = @topic.posts.find!(params[:id])
  end
  
  def update
    @post = @topic.posts.find!(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated successfully"
      redirect_to category_topic_path(@category, @topic, :anchor => "post-#{@post.id}")
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      render :action => 'edit'
    end
  end

  def destroy
    @post = @topic.posts.find!(params[:id])

    @post.destroy
    flash[:success] = "Post deleted successfully"
    
    redirect_to category_topic_path(@category, @topic)
  end
   
  private
  def find_topic
    @category = Category.find!(params[:category_id])
    @topic = @category.topics.find!(params[:topic_id])
  end
end
