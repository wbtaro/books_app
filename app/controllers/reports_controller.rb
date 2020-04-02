# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  def index
    @reports = current_user.reports.page params[:page]
  end

  # GET /reports/1
  def show
    @owner = @report.user
    set_posted_comments_and_commenters(@report)
    set_new_comment(@report)
  end

  # GET /reports/new
  def new
    @report = Report.new
    @report.date = Time.now
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id

    if @report.save
      redirect_to @report, notice: I18n.t("results.common.create", resource: I18n.t("activerecord.models.report.one"))
    else
      render :new
    end
  end

  # PATCH/PUT /reports/1
  def update
    if !current_user_is_owner(@report.user_id)
      redirect_to @report, notice: I18n.t("warnings.invalid_operation")
      return
    end

    if @report.update(report_params)
      redirect_to @report, notice: I18n.t("results.common.update", resource: I18n.t("activerecord.models.report.one"))
    else
      render :edit
    end
  end

  # DELETE /reports/1
  def destroy
    if !current_user_is_owner(@report.user_id)
      redirect_to @report, notice: I18n.t("warnings.invalid_operation")
      return
    end

    @report.destroy
    redirect_to reports_url, notice: I18n.t("results.common.destroy", resource: I18n.t("activerecord.models.report.one"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:title, :date, :text)
    end
end
