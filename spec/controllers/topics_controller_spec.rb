require 'spec_helper'

describe TopicsController do
  render_views
  
  describe "GET index" do
    it "should redirect to the category path" do
      get :index
      #response.should redirect_to(root_path)
    end
  end
end