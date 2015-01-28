class ChangeFloatColumnsToIntegers < ActiveRecord::Migration
  def change
    change_column :lines, :original_list_price, :integer
    change_column :lines, :list_price, :integer
    change_column :lines, :sale_price, :integer
  end
end
