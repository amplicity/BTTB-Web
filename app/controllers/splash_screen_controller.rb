class SplashScreenController < ApplicationController
	def index
    	@posts = Post.all
  	end
end
