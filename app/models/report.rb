class Report < ActiveRecord::Base
  has_many :lines

  def percent_green
    lines.green.count.to_f / lines.count.to_f
  end

  def percent_yellow
    lines.yellow.count.to_f / lines.count.to_f
  end

  def percent_red
    lines.red.count.to_f / lines.count.to_f
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


  ViewObj = Struct.new(:report, :scope) do

    def lines
      @lines ||= report.lines.send(scope)
    end

    def avg_original_list_price
      lines.average(:original_list_price)
    end

    def avg_list_price
      lines.average(:list_price)
    end

    def avg_sale_price
      lines.average(:sale_price)
    end

    def avg_olp_to_sp_percentage
      lines.map(&:olp_to_sp_percentage).inject(:+) / lines.count
    end

    def avg_days_on_market
      lines.average(:days_on_market).to_i
    end

    def avg_rooms
      lines.average(:rooms).to_i
    end

    def avg_beds
      lines.average(:beds).to_i
    end

    def avg_baths
      lines.average(:baths).to_i
    end
  end
end
