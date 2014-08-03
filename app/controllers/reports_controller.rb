require 'csv'
class ReportsController < ApplicationController
  def show
    @report = Report.find params[:id]
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
