require 'spec_helper'

describe TopicsController do
  render_views
  
  before(:all) do
    @category = create(:category)
    @user = create(:user)
  end
  
  after(:all) do
    Category.delete_all
    Topic.delete_all
    User.delete_all
  end
  
  describe "GET index" do
    it "should redirect to category path" do
      get :index, :category_id => @category.id
      response.should redirect_to(category_path(@category))
    end
  end
  
  describe "GET show" do
    before(:each) do
      @topic = @category.topics.create!(:title => "Title", :text => "text", :user => @user)
    end
    
    it "should be success" do
      get :show, :category_id => @category.id, :id => @topic.id
      response.should be_success      
    end
    
    it "should render show template" do
      get :show, :category_id => @category.id, :id => @topic.id
      response.should render_template('topics/show')
    end
  end

  describe "GET new" do
    before(:each) do
      controller.stubs(:sign_in_required).returns(true)
      controller.stubs(:current_user => @user)
    end
    
    it "should be success" do
      get :new, :category_id => @category.id
      response.should be_success
    end
    
    it "should render the new template" do
      get :new, :category_id => @category.id
      response.should render_template('topics/new')
    end
  end
  
  describe "POST create" do
    before(:each) do
      controller.stubs(:sign_in_required).returns(true)
      controller.stubs(:current_user => @user)
    end
    
    it "should redirect to the topic" do
      post :create, :category_id => @category.id, :topic => {:title => "Title", :text => "text"}
      response.should redirect_to([@category, @topic])
    end    
  end
  
  describe "GET edit" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      controller.stubs(:current_user => @user)
      @topic = @category.topics.create!(:title => "Title", :text => "Text", :user => @user)
    end
    
    it "should be success" do
      get :edit, :category_id => @category.id, :id => @topic.id
      response.should be_success
    end
    
    it "should render the new template" do
      get :edit, :category_id => @category.id, :id => @topic.id
      response.should render_template('topics/edit')
    end
  end
  
  describe "PUT update" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @topic = @category.topics.create!(:title => "Title", :text => "Text", :user => @user)
    end
    
    it "should redirect to the topic" do
      put :update, :category_id => @category.id, :id => @topic.id, :topic => {:title => "Name 2"}
      response.should redirect_to([@category, @topic])
    end    
  end
  
  describe "DELETE destroy" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @topic = @category.topics.create!(:title => "Title", :text => "Text", :user => @user)
    end
    
    it "should redirect to category" do
      delete :destroy, :category_id => @category.id, :id => @topic.id
      response.should redirect_to(@category)
    end
  end
end