class ForumsController < ApplicationController
  layout 'application'
  def index
    @categories = Category.all
  end
end