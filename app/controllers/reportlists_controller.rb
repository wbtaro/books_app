class ReportlistsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @reports = @user.reports.page params[:page]
  end
end
