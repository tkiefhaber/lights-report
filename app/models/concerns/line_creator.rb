class LineCreator

  def self.create(report, row)
    new(report, row).create_line if row["MlsNum"].present?
  end

  def initialize(report, row)
    @report = report
    @row = row
  end

  def create_line
    report.lines.create(formatted_row_hash)
  end

  def formatted_row_hash
    {
      address:             address,
      original_list_price: original_list_price,
      list_price:          list_price,
      sale_price:          sale_price,
      days_on_market:      days_on_market,
      rooms:               rooms,
      beds:                beds,
      baths:               baths,
      closed:              closed,
    }
  end

  private
  attr_reader :report, :row

  def address
    [row["StreetNumDisplay"], row["StreetName"]].join(' ')
  end

  def original_list_price
    row["OrigListPrice"].to_i
  end

  def list_price
    row["ListPrice"].to_i
  end

  def sale_price
    row["SalesPrice"].to_i
  end

  def days_on_market
    row["DOMAct"].to_i
  end

  def rooms
    row["Rooms"].to_i
  end

  def beds
    row["Beds"].to_i
  end

  def baths
    row["BathsTotal"].to_i
  end

  def closed
    Date.civil(year, month, day)
  end

  def year
    date_parts[0].to_i
  end

  def month
    date_parts[1].to_i
  end

  def day
    date_parts[2].split(' ').first.to_i
  end

  def date_parts
    @date ||= row["ClosedDate"].split('-')
  end

end
