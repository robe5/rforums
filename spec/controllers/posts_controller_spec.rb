require 'spec_helper'

describe PostsController do
  render_views

  before(:all) do
    @user = User.create!(:email => "a#{Time.now.to_i.to_s}@a.com", :name => "a", :password => "12341234", :password_confirmation => "12341234")    
    @category = Category.create!(:name => 'category')
    @topic = @category.topics.create!(:title => "Title", :text => "Text", :user => @user)
  end
  
  after(:all) do
    Category.delete_all
    Topic.delete_all
    Post.delete_all
    User.delete_all
  end
  
  describe "POST create" do
    before(:each) do
      controller.stubs(:sign_in_required).returns(true)
      controller.stubs(:current_user => @user)
    end
    
    it "should redirect to the topic with anchor" do
      post :create, :category_id => @category.id, :topic_id => @topic.id, :post => {:text => "text"}
      response.should redirect_to(category_topic_path(@category, @topic, :anchor => "post-#{assigns[:post].id}"))
    end    
  end
  
  describe "GET edit" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @post = @topic.posts.create!(:text => "Text", :user => @user)
    end
    
    it "should be success" do
      get :edit, :category_id => @category.id, :topic_id => @topic.id, :id => @post.id
      response.should be_success
    end
    
    it "should render the edit template" do
      get :edit, :category_id => @category.id, :topic_id => @topic.id, :id => @post.id
      response.should render_template('posts/edit')
    end
  end
  
  describe "PUT update" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @post = @topic.posts.create!(:text => "Text", :user => @user)
    end
    
    it "should redirect to the topic with anchor" do
      put :update, :category_id => @category.id, :topic_id => @topic.id, :id => @post.id, :post => {:text => "Name 2"}
      response.should redirect_to(category_topic_path(@category, @topic, :anchor => "post-#{@post.id}"))
    end    
  end
  
  describe "DELETE destroy" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @post = @topic.posts.create!(:text => "Text", :user => @user)
    end
    
    it "should redirect to the ropic" do
      delete :destroy, :category_id => @category.id, :topic_id => @topic.id, :id => @post.id
      response.should redirect_to([@category, @topic])
    end
  end
end