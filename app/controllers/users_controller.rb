class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  # Very simple authentication
  def authorize
    @user = User.find_by_name(params[:name])
    if params[:password] == @user.password
      true
    end
  end
end
