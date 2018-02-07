class Article < ApplicationRecord

  belongs_to :user
  # 浮動小数点数で格納されているので小数点以下を切り捨てる
  # def redis_page_view
  #   REDIS.zscore("ranking",@article.id).floor
  # end

  # include Redis::Objects
  #
  #   sorted_set :views, global: true
  #
  #   def increment_view
  #     self.class.views.increment(id)
  #   end
  #
  #   def views
  #     self.class.views[id].to_i
  #   end
  #
  #   class << self
  #     def ranking(num = 5)
  #       ids = views.revrange(0, (num - 1))
  #       ids.map { |id| find(id) }
  #     end
  #   end

end
