# frozen_string_literal: true

class SessionsController < ApplicationController

  def new; end

  def create
    @user = User.authenticate(params[:email_address], params[:password])
    if @user
      session[:current_user] = @user
      redirect_to trackers_path
    else
      render :new
    end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

end
