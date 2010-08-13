require 'spec_helper'

describe CategoriesController do
  render_views
  
  describe "GET index" do
    it "should redirect to root path" do
      get :index
      response.should redirect_to(root_path)
    end
  end
end