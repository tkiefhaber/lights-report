class AddUnitsToLine< ActiveRecord::Migration
  def change
    add_column :lines, :units, :integer
  end
end
