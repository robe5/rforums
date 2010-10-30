class ForumsController < ApplicationController
  layout 'application'

  def index
    @categories = Category.all(:order => 'position ASC')
    @items = Item.recent(10)
  end
end
