class ArticlesController < ApplicationController

  # require 'date'

  def index
    @articles = Article.order("updated_at DESC").all

    # .order(created_at: 'desc')
    get_ranking
  end

  def show
    @article = Article.find(params[:id])
    REDIS.zincrby "ranking", 1, "#{@article.id}"
    get_ranking
    @article.updated_at = Time.now.to_s(:db)
    @article.save
  end

  def new
     @article = Article.new
     @article.updated_at = Time.now.to_s(:db)
     @article.save
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_create_params)
    if @article.save
      REDIS.zadd "ranking", 0, "#{@article.id}"
      redirect_to  root_path
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_update_params)
        redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    REDIS.zrem "ranking",  "#{@article.id}"
    redirect_to articles_path
  end


private
      def article_create_params
        params.require(:article).permit(:title, :body, :user_id)
      end

      def article_update_params
        params.require(:article).permit(:title, :body)
      end

      def get_ranking
        ids = REDIS.zrevrangebyscore "ranking", "+inf", 0, limit: [0, 3]
        @ranking = Article.where(id: ids).sort_by{ |article| ids.index(article.id.to_s) }
      end
end
