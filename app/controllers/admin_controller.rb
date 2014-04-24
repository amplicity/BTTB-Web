class AdminController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  
  def index
    @posts = Post.all.order("created_at DESC")
  end


  
  private
  def authenticate
    authenticate_or_request_with_http_basic do |name, password|
        name== "admin" && password == "bangtothebeat"
      end
  end
  
end
