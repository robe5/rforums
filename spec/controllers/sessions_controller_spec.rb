require 'spec_helper'

describe SessionsController do
  render_views
  
  before(:all) do
    @user = create(:user)
  end
  
  describe 'GET index' do
    it "should be success" do
      get :new
      response.should be_success
    end

    it "should render the new template" do
      get :new
      response.should render_template('sessions/new')
    end
  end
  
  describe 'POST create' do
    it "should redirect to root path" do
      post :create, :email => @user.email, :password => "12341234"
      response.should redirect_to(root_path)
    end
    
    it "should assign the current user" do
      post :create, :email => @user.email, :password => "12341234"
      controller.send(:current_user).should == @user
    end
  end
  
  describe 'POST recovery' do
    before(:each) do
      @user.set_password_code!
    end

    it "should redirect to edit user path" do
      post :recovery, :token => @user.reset_password_code
      response.should redirect_to(edit_user_path(@user))
    end
    
    it "should assign the current user" do
      post :recovery, :token => @user.reset_password_code
      controller.send(:current_user).should == @user
    end
  end
  
  describe 'GET destroy' do    
    it "should redirect to root path" do
      get :destroy
      response.should redirect_to(root_path)
    end
    
    it "should unlog the user" do
      controller.send(:current_user=, @user)
      get :destroy
      controller.send(:current_user).should be_nil
    end
  end
end