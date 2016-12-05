class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
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
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article has been successfully updated."
      redirect_to @article
    else
      flash.now[:danger] = "Article has not been updated."
      render :edit
    end
    
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
    
  protected
  
    def resource_not_found
      message = "Uh oh, we couldn't find the article you're looking for."
      flash[:danger] = message
      redirect_to root_path
    end
end
