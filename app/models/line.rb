class Line < ActiveRecord::Base
  belongs_to :report

  def status
    if olp_to_sp_percentage >= 90
      'green'
    elsif olp_to_sp_percentage < 90 && olp_to_sp_percentage >= 80
      'banana'
    else
      'red'
    end
  end
end
