# frozen_string_literal: true

# Allows users to sign up and manage their accounts
#
class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user] = @user
      redirect_to trackers_path
    else
      render :new
    end
  end

end
