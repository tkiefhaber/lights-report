require 'csv'
class ReportsController < ApplicationController
  def show
    @report = Report.find params[:id]
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "lights_report_#{@report.id}",
               :template => 'reports/show.pdf.erb'
      end
    end
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.create
    ::CSV.parse(params[:report][:report].read, headers: true) do |csv|
      @report.lines.create(csv.to_hash)
    end
    redirect_to @report
  end
end
