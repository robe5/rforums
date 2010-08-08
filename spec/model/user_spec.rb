require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
     :name => "User",
     :email => "user@test.com",
     :password => "12341234",
     :password_confirmation => "12341234"
    }
  end

  after(:each) do
    User.destroy_all
  end
  
  it "should be valid with valid_attributes" do
    User.new(@valid_attributes).should be_valid
  end
  
  it "should be invalid without email" do
    User.new(@valid_attributes.except(:email)).should_not be_valid
  end
  
  it "should be invalid with a wrong email" do
    ['test', '2323213.asds', 'blah@blah'].each do |email|
      User.new(@valid_attributes.merge(:email => email)).should_not be_valid
    end
  end
  
  it "should be invalid without name" do
    User.new(@valid_attributes.except(:name)).should_not be_valid
  end
  
  it "should be invalid without password" do
    User.new(@valid_attributes.except(:password)).should_not be_valid
  end
    
  it "should match a password confirmation" do
    @user = User.new(@valid_attributes)
    @user.password = "password1"
    @user.password_confirmation = "password2"
    @user.should_not be_valid
  end
  
  it "should have a unique email" do
    @user1 = User.create(@valid_attributes)
    @user2 = User.new(@valid_attributes)
    @user2.should_not be_valid
  end
  
  it "should be admin if its the first user created" do
    @user1 = User.create(@valid_attributes)
    @user1.should be_admin
    @user2 = User.create(@valid_attributes)
    @user2.should_not be_admin
  end
  
  it "should have a role" do
    @user = User.new(@valid_attributes)
    @user.role.should == "member"
    @user.admin = true
    @user.role.should == "admin"
  end
  
  it "should authenticate" do
    @user = User.create(@valid_attributes)
    User.authenticate(@valid_attributes[:email], @valid_attributes[:password]).should == @user
  end
  
  it "should not authenticate" do
    @user = User.create(@valid_attributes)
    User.authenticate(@valid_attributes[:email], "testtest").should be_nil
  end
  
  it "should change the password" do
    @user = User.create(@valid_attributes)
    @user.password = @user.password_confirmation = "new_password"
    User.authenticate(@valid_attributes[:email], "new_password")
  end
  
end