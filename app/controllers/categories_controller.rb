class CategoriesController < ApplicationController  
  def show
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Category was successfully created"
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
      flash[:success] = "Category was successfully updated"
    else
      flash[:success] = @category.errors.full_messages.to_sentence
    end
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:success] = "Category was successfully destroyed"
    else
      flash[:error] = "Category was not destroyed"
    end
    respond_to do |format|
      format.js
    end
  end
end