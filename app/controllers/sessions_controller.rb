# frozen_string_literal: true

# Handles user sessions - login and logout
#
class SessionsController < ApplicationController

  layout 'narrow'

  before_action only: %i[new create] do

  end

  def new
    @login_form = LoginForm.new
    render 'forms/simple_login_form'
  end

  def create
    @login_form = LoginForm.new(login_params)
    # if @login_form.validate

    if @login_form.valid?
      session[:current_user] = @login_form.authenticated_user
      redirect_to trackers_path
    else
      puts @login_form.inspect
      render 'forms/simple_login_form', status: 401
    end

    # @user = User.authenticate(params[:email_address], params[:password])
    # if @user
    #   session[:current_user] = @user
    #   redirect_to trackers_path
    # else
    #   render :new
    # end
  end

  def destroy
    session[:current_user] = nil
    redirect_to root_path
  end

  private

  def login_params
    params.require(:login_form).permit(:email_address, :password)
  end

end
