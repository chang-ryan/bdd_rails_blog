class ArticlesController < ApplicationController
  def index
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
  
  private
  
    def article_params
      params.require(:article).permit(:title, :body)
    end
end
