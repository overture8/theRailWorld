# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :footer

  # Common items which appear on the footer of every page
  def footer
    @archives = Post.all(:group => "month(created_at)", :select => "created_at, title")
    @tags = Post.tag_counts
    @recent_posts = Post.all(:limit => 10, :order => "created_at DESC")
  end
  
  def require_auth
    redirect_to authorize_path
  end
end
