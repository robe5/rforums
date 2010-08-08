require 'spec_helper'

describe UsersController do
  render_views
  
  describe 'GET new' do
    it "should be success" do
      get 'new'
      response.should be_success
    end
  end # GET new
  
  describe 'POST create' do    
    context 'with right params' do
      before(:each) do
        @params = {:name => "Name", :email => "test@test.com", :password => "12341234", :password_confirmation => "12341234"}
      end
      
      after(:each) do
        User.destroy_all
      end
      
      it "should create a new user" do
        lambda{
          post 'create', :user => @params
        }.should change(User, :count).by(1)
      end
      
      it "should redirect to root path" do
        post 'create', :user => @params
        response.should redirect_to(root_path)
      end
    end # with right params
    
    context 'with wrong params' do      
      it "should not create a new user" do
        lambda{
          post 'create', :user => {}
        }.should_not change(User, :count)
      end
      
      it "should render the 'new' template" do
        post 'create', :user => {}
        response.should render_template(:new)
      end
      
      it "should display a flash error" do
        post 'create', :user => {}
        flash[:error].should be_present
      end
    end # with wrong params
  end # POST create
  
  describe "GET show" do
    before(:each) do
      @user = User.new(:name => "Name", :email => "test@test.com")
      User.stubs(:find).returns(@user)
    end
    
    it "render template 'show'" do
      get 'show', :id => @user.id.to_s
      response.should render_template 'show'
    end
    
    it "should assign user variable" do
      get 'show', :id => @user.id.to_s
      assigns(:user).should == @user
    end
  end
  
  describe 'GET edit' do
    before(:each) do
      @user = User.new(:name => "Name", :email => "test@test.com")
      User.stubs(:find).returns(@user)
    end
    
    context 'not logged in' do
      it "should redirect to login path if user is not logged" do
        get 'edit', :id => @user.id.to_s
        response.should redirect_to(login_path)
      end
    end # not logged in
    
    context 'logged in' do
      before(:each) do
        controller.stubs(:current_user).returns(@user)
      end
      
      it "should redirect to user show if user logged is not the user to edit" do
        @other_user = User.new
        get 'edit', :id => @other_user.id.to_s
        response.should redirect_to(user_path(@other_user.id.to_s))
      end
      
      it "should have a flash error if user logged is not the user to edit" do
        @other_user = User.new
        get 'edit', :id => @other_user.id.to_s
        flash[:error].should be_present
      end
      
      it "should not redirect" do
        response.should_not be_redirect
      end
            
      it "should render template 'edit'" do
        get 'edit', :id => @user.id.to_s
        response.should render_template(:edit)
      end
      
    end # logged in
  end # GET edit
  
  describe 'PUT update' do
    before(:each) do
      @user = User.new(:name => "Name", :email => "test@test.com")
      User.stubs(:find).returns(@user)
    end
        
    context 'logged in' do
      before(:each) do
        controller.stubs(:current_user).returns(@user)
      end
      
      it "should redirect to user on update" do
        @user.expects(:update_attributes).returns(true)
        put 'update', :id => @user.id.to_s
        response.should redirect_to(@user)
      end
            
      it "should render template 'edit' on error" do
        @user.expects(:update_attributes).returns(false)
        put 'update', :id => @user.id.to_s
        response.should render_template(:edit)
      end
      
    end # logged in
  end # PUT update
  
  describe 'GET help' do
    it "should be success" do
      get 'help'
      response.should be_success
    end
  end
  
  describe 'POST recover' do
    before(:each) do
      @user = User.new(:name => "User", :email => "user@test.com", :password => 12341234, :password_confirmation => 12341234)
      
    end
    
    context 'with a valid email' do
      before(:each) do
        User.expects(:first).with(:conditions => {:email => "user@test.com"}).returns(@user)
        @user.stubs(:set_password_code!)
      end
      
      it "should set the password code" do
        @user.expects(:set_password_code!)
        post :recover, :email => "user@test.com"
      end
    
      it "should have a flash success message" do
        post :recover, :email => "user@test.com"
        flash.should have_key(:success)
      end
      
      it "should redirect to root path" do
        post :recover, :email => "user@test.com"
        response.should redirect_to(root_path)
      end
    end
    
    context 'with an invalid email' do
      before(:each) do
        User.expects(:first).with(:conditions => {:email => "user@test.com"}).returns(nil)
      end

      it "should have a flash error message" do
        post :recover, :email => "user@test.com"
        flash.should have_key(:error)
      end
      
      it "should redirect to help user path" do
        post :recover, :email => "user@test.com"
        response.should redirect_to(help_user_path)
      end
    end
  end
end