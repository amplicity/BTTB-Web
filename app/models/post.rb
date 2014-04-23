class Post < ActiveRecord::Base
	validates_presence_of :body, :title, :soundcloud_url, :image_url
	acts_as_taggable
end
