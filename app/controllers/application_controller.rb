require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get '/posts/new' do
      erb :new
  end

  post '/posts' do
      #binding.pry
      @post = Post.create(params)
      #same as (name: params[:name])
      #hcreate - new and saves post - new and initialize
      redirect_to '/posts'
  end

  get '/posts' do
      if params[:message]
      @message = params[:message]
  end
      @posts = Post.all
      erb :index
  end

  get '/posts/:id' do

      @post = Post.find(params[:id])
      #binding.pry
      erb :show
  end


  get '/posts/:id/edit' do
      @post = Post.find(params[:id])
      erb :edit
  end

  patch '/posts/:id/edit' do
      @post = Post.find(params[:id])
      #@post.name = params[:name]
      #@post.content = params[:content]
      @post.update(name: params[:name], content: params[:content])

      #@post.update(params[:name], [:content])

      redirect "/posts/#{@post.id}"

  end


    delete '/posts/:id/delete' do
        @post = Post.find(params[:id])
        @message = "#{@post.name} was deleted."
        @post.delete
        redirect to "/posts?message=#{@message}"
    end

end
#redirect from post methods and erb for get methods


#why redirect?
