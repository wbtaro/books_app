# frozen_string_literal: true

class ReportlistsController < ApplicationController
  def index
    followees = current_user.followees
    @reports = Report.where(user_id: followees).order(updated_at: :DESC).page params[:page]
    @users = {}
    followees.each do |followee|
      @reports.each { |report| @users[report.id] = followee if followee.id == report.user_id }
    end
  end

  def show
    @user = User.find(params[:id])
    @reports = @user.reports.page params[:page]
  end
end
