class ForumsController < ApplicationController
  layout 'application'
  def index
    @categories = Category.all
    @items = Item.recent(10)
  end
end