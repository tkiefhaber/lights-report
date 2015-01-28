class Line < ActiveRecord::Base
  belongs_to :report
  scope :green,  -> { where('CAST(sale_price AS FLOAT) / CAST(original_list_price AS FLOAT) >= 1.0') }
  scope :yellow, -> { where('CAST(sale_price AS FLOAT) / CAST(original_list_price AS FLOAT) < 1.0 AND CAST(sale_price AS FLOAT) / CAST(original_list_price AS FLOAT) >= 0.9') }
  scope :red,    -> { where('CAST(sale_price AS FLOAT) / CAST(original_list_price AS FLOAT) < 0.9') }

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
    @olp_to_sp_percentage ||= (sale_price.to_f / original_list_price.to_f) * 100
  end
end
