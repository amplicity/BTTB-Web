class PostsController < ApplicationController
  #for parsing uri
  require 'open-uri'
  #for parsing json from uri
  require 'json'
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :except => [:index, :show, :play]
  # GET /posts
  # GET /posts.json
  def play
   @client_id = "e2d9022d3a7c8321d8582a73674106a8"
    @post = Post.find(params[:post_id])
    url_string = "http://api.soundcloud.com/resolve.json?url=" + @post.soundcloud_url + "&client_id=" + @client_id
    #catch error if soundcloud track is invalid
    begin
      data = open(url_string)
      result = JSON.parse(data.read)
      track_id = result["id"]
      @track_url = "/tracks/" + track_id.to_s
      @valid_link = true
    rescue
      #flag invalid link
      @valid_link = false
    end



    respond_to do |format|
      format.js
    end

  end

  def index
    @posts = Post.all.order("created_at DESC")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_url }
      format.json { head :no_content }
    end
  end

 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :soundcloud_url, :image_url, :tag_list)
    end

    private
    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
          name== "admin" && password == "bangtothebeat"
        end
    end

end
