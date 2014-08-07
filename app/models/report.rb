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
end
