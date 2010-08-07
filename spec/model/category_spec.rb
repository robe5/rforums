require 'spec_helper'

describe Category do
  before(:each) do
    @valid_attributes = {
      :name => "category",
      :description => "Description of the category"
    }
    @category = Category.new
  end

  it "should be valid with valid attributes" do
    @category.attributes = @valid_attributes
    @category.should be_valid
  end

  it "should not be valid without name" do
    @category.attributes = @valid_attributes.except(:name)
    @category.should_not be_valid
  end  
end
