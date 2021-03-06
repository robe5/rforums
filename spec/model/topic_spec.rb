require 'spec_helper'

describe Topic do
  before(:all) do
    @user = create(:user)
    @category = create(:category)
  end

  before(:each) do
    @valid_attributes = {
      :title => "topic 1",
      :text => "text",
      :user_id => @user.id,
      :category_id => @category.id
    }
    @topic = Topic.new
  end
  
  it "should be valid with valid attributes" do
    @topic.attributes = @valid_attributes
    @topic.should be_valid
  end
  
  it "should not be valid without title" do
    @topic.attributes = @valid_attributes.except(:title)
    @topic.should_not be_valid
  end
  
  it "should not be valid without category" do
    @topic.attributes = @valid_attributes.except(:category_id)
    @topic.should_not be_valid
  end
  
  it "should not be valid without user" do
    @topic.attributes = @valid_attributes.except(:user_id)
    @topic.should_not be_valid
  end
  
  it "should have an initial post count of zero" do
    @topic.attributes = @valid_attributes
    @topic.post_count.should == 0
  end
  
  it "should increment its posts count" do
    @topic = Topic.create(@valid_attributes)
    lambda{
      @topic.send :increment, 1
      @topic.reload
    }.should change(@topic, :post_count).by(1)
  end
  
  it "should decrement its posts count" do
    @topic = Topic.create(@valid_attributes)
    lambda{
      @topic.send :increment, -1
      @topic.reload
    }.should change(@topic, :post_count).by(-1)
  end
end
