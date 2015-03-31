require 'csv'
class ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def show
    @report = Report.find params[:id]
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "lights_report_#{@report.id}",
               :template => 'reports/show.pdf.erb'
      end
      format.xls
    end
  end

  def new
    @report = Report.new
  end

  def create
    begin
      @report = Report.create
      report_string = File.open(params[:report][:report].path).read.to_s.gsub('\r', '\n')
      ::CSV.parse(report_string.gsub("\r", "\n"), col_sep: "\t", headers: true).each do |row|
        next unless row.to_hash["MlsNum"].present?
        @town = row.to_hash["Town"]
        LineCreator.create(@report, row.to_hash)
      end
      @report.name = params[:report][:name].strip.present? ? params[:report][:name] : "#{@town} - #{Date.today.month.to_s}/#{Date.today.year.to_s}"
      @report.save!
      redirect_to @report
    rescue => e
      flash[:error] = e.message
      redirect_to :back
    end
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy
    flash[:notice] = 'deleted report'
    redirect_to action: 'index'
  end
end
