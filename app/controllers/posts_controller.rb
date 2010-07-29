class PostsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.topic = @topic
    
    if @post.save
      flash[:success] = "Post created"
      redirect_to [@topic.category, @topic], :anchor => "topic-#{@post.id}"
    else
      flash[:error] = @topic.errors.full_messages.to_sentence
      redirect_to [@topic.category, @topic], :anchor => 'reply'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @topic = @post.topic
    
    if @post.destroy
      flash[:success] = "Post deleted"
    else
      flash[:error] = @post.errors.full_messages.to_sentence
    end
    redirect_to [@topic.category, @topic]
  end
end