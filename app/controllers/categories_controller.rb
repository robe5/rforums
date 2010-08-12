class CategoriesController < ApplicationController  
  before_filter :authorized?, :only => [:create, :update, :destroy]
  before_filter :admin_required, :only => [ :create ]
  
  def index
    redirect_to root_path
  end
  
  def show
    @category = Category.find!(params[:id])
    @topics = @category.topics.paginate(:order => 'level DESC, updated_at DESC', :per_page => 10, :page => params[:page])
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Category #{@category.name} was successfully created"
    else
      flash[:error] = @category.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Category #{@category.name} was successfully updated"
    else
      flash[:success] = @category.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "Category #{@category.name} was successfully destroyed"
    
    respond_to do |format|
      format.js
    end
  end
end