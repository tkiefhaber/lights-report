class AddUnitsToLine< ActiveRecord::Migration[5.2]
  def change
    add_column :lines, :units, :integer
  end
end
