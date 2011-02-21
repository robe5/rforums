class CategoriesController < ApplicationController  
  before_filter :admin_required, :only => [ :create, :order, :update, :destroy ]
  
  def index
    redirect_to root_path
  end
  
  def show
    @category = Category.find!(params[:id])
    @topics = @category.topics.paginate(:order => 'level DESC, created_at DESC', :per_page => 10, :page => params[:page])
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

  def order
    if params[:category].present?
      params[:category].each_with_index do |c_id, i|
	      category = Category.find(c_id)
        category.update_attributes(:position => i)
      end
      flash.now[:success] = "Categories was successfully ordered"
    else
      flash.now[:error] = "Categories could not be reordered"
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
