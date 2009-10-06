# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include TagsHelper
 
  # Is the current page the home page?
  def is_home?
    params[:controller] == "posts" && params[:action] == "index"
  end
  
end

