require 'authentication'
class ApplicationController < ActionController::Base
  protect_from_forgery
  include Authentication
  layout 'application'
  
  rescue_from MongoMapper::DocumentNotFound, :with => :document_not_found
  
  private  
  def document_not_found
    flash[:error] = "Document not found"
    redirect_to root_path and return
  end
end
