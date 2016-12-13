class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    # udemy course used @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      # flash waits for a redirect (ie. it survives a redirect)
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      # flash now can be used for render
      render :new
    end
  end
  
  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article has been successfully updated."
      redirect_to @article
    else
      flash.now[:danger] = "Article has not been updated."
      render :edit
    end
  end
  
  def destroy
    if @article.destroy
      flash[:success] = "Article has successfully been deleted."
      redirect_to articles_path
    end
  end
  
  protected
  
    def resource_not_found
      message = "Uh oh, we couldn't find the article you're looking for."
      flash[:danger] = message
      redirect_to root_path
    end

    def correct_user
      unless @article.user == current_user
        flash[:notice] = "Hey, that's not your article!"
        redirect_to root_path
      end
    end

  private

    def set_article
      @article = Article.find(params[:id])
    end
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
