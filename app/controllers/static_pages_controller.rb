class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = paginate(current_user.feed)
    end
  end

  def help
  end

  def about
  end
  
  def contact
  end
end
