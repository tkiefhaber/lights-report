class Line < ActiveRecord::Base
  belongs_to :report
  scope :green,  -> { where('olp_to_sp_percentage >= 90') }
  scope :yellow, -> { where('olp_to_sp_percentage < 90 AND olp_to_sp_percentage >= 80') }
  scope :red,    -> { where('olp_to_sp_percentage < 80') }

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
