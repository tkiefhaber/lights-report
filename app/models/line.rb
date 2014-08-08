class Line < ActiveRecord::Base
  belongs_to :report
  default_scope { where('sale_price / original_list_price') }
  scope :green,  -> { where('sale_price / original_list_price >= 1.0') }
  scope :yellow, -> { where('sale_price / original_list_price < 1.0 AND sale_price / original_list_price >= 0.9') }
  scope :red,    -> { where('sale_price / original_list_price < 0.9') }

  def status
    if olp_to_sp_percentage >= 100
      'green'
    elsif olp_to_sp_percentage < 100 && olp_to_sp_percentage >= 90
      'banana'
    else
      'red'
    end
  end

  def olp_to_sp_percentage
    @olp_to_sp_percentage ||= (sale_price / original_list_price) * 100
  end
end
