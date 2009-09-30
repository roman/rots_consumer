class UsersController < ApplicationController
  
  # signup
  def new
    attrs = flash.include?(:user_attributes) ? flash.delete(:user_attributes) : {}
    @user = User.new(attrs)
  end
  
end
