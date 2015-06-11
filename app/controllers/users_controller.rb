# class UsersController < ApplicationController
#   def show
#     @user = User.find(params[:id])
#     @topics = Topic.where(user_id:@user.id).order('created_at DESC').limit(10)
#     @replies = Reply.where(user_id:@user.id).order('created_at DESC').limit(10)
#     @facebook_info = env["omniauth.auth"]
#   end
#
# end
