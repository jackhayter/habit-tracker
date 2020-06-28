# frozen_string_literal: true

# Manages the different grades that can be assigned to entries in a tracker
#
class GradesController < ApplicationController

  before_action do
    @tracker = current_user.trackers.find(params[:tracker_id])
    @grade = @tracker.grades.find(params[:id]) if params[:id]
  end

  def index; end

  def new
    @grade = @tracker.grades.new
  end

  def create
    @grade = @tracker.grades.new(grade_params)
    if @grade.save
      redirect_to grades_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @grade.update_attributes(grade_params)
      redirect_to grades_path
    else
      render :edit
    end
  end

  def destroy
    flash[:errors] = @grade.errors unless @grade.destroy
    redirect_to grades_path
  end

end
