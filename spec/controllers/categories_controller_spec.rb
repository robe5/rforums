require 'spec_helper'

describe CategoriesController do
  render_views

  after(:all) do
    Category.delete_all
  end
  
  describe "GET index" do
    it "should redirect to root path" do
      get :index
      response.should redirect_to(root_path)
    end
  end
  
  describe "GET show" do
    before(:each) do
      @category = Category.create(:name => "Name")
    end
    
    it "should be success" do
      get :show, :id => @category.id
      response.should be_success      
    end
    
    it "should render show template" do
      get :show, :id => @category.id
      response.should render_template('categories/show')
    end
  end
  
  describe "POST create" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
    end
    
    it "should be success" do
      post :create, :category => {:name => "name"}, :format => :js
      response.should be_success
    end
    
    it "should render create template" do
      post :create, :category => {:name => "name"}, :format => :js
      response.should render_template('categories/create')
    end
  end
  
  describe "PUT update" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @category = Category.create(:name => "name1")
    end
    
    it "should be success" do
      put :update, :id => @category.id, :category => {:name => "Name 2"}, :format => :js
      response.should be_success
    end
    
    it "should render update template" do
      put :update, :id => @category.id, :category => {:name => "Name 2"}, :format => :js
      response.should render_template('categories/update')
    end
  end
  
  describe "DELETE destroy" do
    before(:each) do
      controller.stubs(:admin_required).returns(true)
      @category = Category.create(:name => "name1")
    end

    it "should be success" do
      delete :destroy, :id => @category.id, :format => :js
      response.should be_success
    end
    
    it "should render destroy template" do
      delete :destroy, :id => @category.id, :format => :js
      response.should render_template('categories/destroy')
    end
  end
end