# frozen_string_literal: true

# Manages trackers created by users
#
class TrackersController < ApplicationController

  before_action do
    @tracker = current_user.trackers.find(params[:id]) if params[:id]
  end

  def index
    @trackers = [] # current_user.trackers
  end

  def show; end

  def new
    @tracker = current_user.trackers.new
  end

  def create
    @tracker = current_user.trackers.new(tracker_params)
    if @tracker.save
      render :new
    else
      redirect_to trackers_path
    end
  end

  def edit; end

  def update
    if @tracker.update(tracker_params)
      redirect_to trackers_path
    else
      render :edit
    end
  end

  def destroy
    flash[:errors] = @tracker.errors unless @tracker.destroy
    redirect_to trackers_path
  end

end
