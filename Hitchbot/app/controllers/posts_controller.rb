class PostsController < ApplicationController
	def index
		@new_post = Post.new
		@all_posts = Post.order(created_at: :desc).all

		require 'nokogiri'
		file = File.open("#{Rails.root}/public/products.xml")
		doc = Nokogiri::XML(file)

		@links = doc.xpath('//items/item').map do |i| 
	  	{'id' => i.xpath('id').text, 'title' => i.xpath('title').text, 
		'url' => i.xpath('link').text, 'img' => i.xpath('image').text,
		'design' => i.xpath('design').text,'cat' => i.xpath('categories').text,
		'desc' => i.xpath('description').text,'price' => i.xpath('price').text,
		'create' => i.xpath('created_on').text}
		end
	end

	def create
		@new_post = Post.new(post_params)
		@new_post.save
		redirect_to '/posts'
	end

	private
	def post_params
		params.require(:post).permit(:name, :comment)
	end
end
