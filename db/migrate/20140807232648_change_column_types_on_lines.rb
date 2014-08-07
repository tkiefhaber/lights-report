class ChangeColumnTypesOnLines < ActiveRecord::Migration
  def change
    change_column :lines, :original_list_price, :float
    change_column :lines, :list_price, :float
    change_column :lines, :sale_price, :float
    remove_column :lines, :olp_to_sp_percentage
  end
end
