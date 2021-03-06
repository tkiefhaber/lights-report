class Report < ActiveRecord::Base
  has_many :lines, dependent: :destroy

  def percent_green
    @percent_green ||= lines.green.count.to_f / lines.count.to_f
  end

  def percent_yellow
    @percent_yellow ||= lines.yellow.count.to_f / lines.count.to_f
  end

  def percent_red
    @percent_red ||= lines.red.count.to_f / lines.count.to_f
  end

  def total_percentage
    [percent_green, percent_yellow, percent_red].sum.to_i
  end

  def green_average
    @green_average ||= ViewObj.new(self, :green)
  end

  def yellow_average
    @yellow_average ||= ViewObj.new(self, :yellow)
  end

  def red_average
    @red_average ||= ViewObj.new(self, :red)
  end

  def avg_olp
    lines.average(:original_list_price)
  end

  def avg_lp
    lines.average(:list_price)
  end

  def avg_sp
    lines.average(:sale_price)
  end

  def avg_olp_to_sp
    ((green_average.avg_olp_to_sp_percentage + yellow_average.avg_olp_to_sp_percentage + red_average.avg_olp_to_sp_percentage) / 3).to_f
  end

  def avg_dom
    lines.average(:days_on_market).to_i
  end

  def avg_rooms
    lines.average(:rooms).to_f.round(1)
  end

  def avg_beds
    lines.average(:beds).to_f.round(1)
  end

  def avg_baths
    lines.average(:baths).to_f.round(1)
  end

  def avg_units
    if show_units?
      lines.average(:units).to_i
    end
  end

  def show_units?
    lines.pluck(:units).compact.present?
  end


  ViewObj = Struct.new(:report, :scope) do

    def lines
      @lines ||= report.lines.send(scope)
    end

    def avg_original_list_price
      lines.average(:original_list_price).to_i
    end

    def avg_list_price
      lines.average(:list_price).to_i
    end

    def avg_sale_price
      lines.average(:sale_price).to_i
    end

    def avg_olp_to_sp_percentage
      begin
        (lines.map(&:olp_to_sp_percentage).inject(:+) / lines.count).to_f
      rescue
        0.to_f
      end
    end

    def avg_days_on_market
      lines.average(:days_on_market).to_i
    end

    def avg_units
      if report.show_units?
        lines.average(:units).to_i
      end
    end

    def avg_rooms
      lines.average(:rooms).to_f.round(1)
    end

    def avg_beds
      lines.average(:beds).to_f.round(1)
    end

    def avg_baths
      lines.average(:baths).to_f.round(1)
    end

    def count
      lines.count
    end
  end
end
