
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles'do
    article = Article.create(title:params[:title],content:params[:content])
    redirect to "/articles/#{article.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by(id:params[:id])
    erb :show
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id/edit' do

    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    # binding.pry
    @article = Article.find_by_id(params[:id])
    @article.title = params[:article][:title]
    @article.content = params[:article][:content]
    @article.save
    erb :show
  end

  delete '/articles/:id' do
    # @article = Article.find_by_id(params[:id])
    # @article.destroy(params[:id])
    Article.destroy(params[:id])
    # erb :delete
    redirect '/article'
  end


end
