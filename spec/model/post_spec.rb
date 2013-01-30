require 'spec_helper'

describe Post do
  before(:all) do
    @user = create(:user)
    @topic = create(:topic)
  end

  before(:each) do
    @valid_attributes = {
      :text => "text",
      :user_id => @user.id,
      :topic_id => @topic.id
    }
    @post = Post.new
  end
  
  it "should be valid with valid attributes" do
    @post.attributes = @valid_attributes
    @post.should be_valid
  end
  
  it "should not be valid without text" do
    @post.attributes = @valid_attributes.except(:text)
    @post.should_not be_valid
  end
  
  it "should not be valid without user" do
    @post.attributes = @valid_attributes.except(:user_id)
    @post.should_not be_valid
  end
  
  it "should not be valid without topic" do
    @post.attributes = @valid_attributes.except(:topic_id)
    @post.should_not be_valid
  end
  
  it "should increment topic post cache on create" do
    @post.attributes = @valid_attributes
    @topic = Topic.new
    @topic.expects(:increment).with(1)
    @post.stubs(:topic).returns(@topic)
    @post.save
  end
  
  it "should decrement topic post cache on destroy" do
    @post.attributes = @valid_attributes
    @topic = Topic.new
    @topic.stubs(:increment)
    @topic.expects(:increment).with(-1)
    @post.stubs(:topic).returns(@topic)
    @post.save
    @post.destroy
  end
end