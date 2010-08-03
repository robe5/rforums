class PostsController < ApplicationController
  before_filter :find_topic
  before_filter :authenticate, :only => [ :create ]
  before_filter :authorized?, :only => [:destroy]  
  
  def create
    params[:post].merge!(:topic => @topic, :user => current_user)
    @post = Post.new(params[:post])
    
    if @post.save
      flash[:success] = "Post created"

      redirect_to [@category, @topic], :anchor => "topic-#{@post.id}"
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      redirect_to category_topic_path(@category, @topic, :anchor => 'reply')
    end
  end
  
  def destroy
    @post = @topic.posts.find!(params[:id])

    @post.destroy
    flash[:success] = "Post deleted successfully"
    
    redirect_to category_topic_path(@category, @topic, :page => params[:page])
  end
   
  private
  def find_topic
    @category = Category.find!(params[:category_id])
    @topic = @category.topics.find!(params[:topic_id])
  end
end