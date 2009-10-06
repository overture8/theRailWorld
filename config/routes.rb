ActionController::Routing::Routes.draw do |map|
  map.resources :posts, :has_many => :comments
  map.resources :categories, :has_many => :posts
  map.resources :posts, :has_many => :categories
  map.authorize '/login', :controller => :users, :action => :new
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :posts
end
