class CreateLines < ActiveRecord::Migration[5.2]
  def change
    create_table :lines do |t|
      t.string :address
      t.integer :original_list_price
      t.integer :list_price
      t.integer :sale_price
      t.float :olp_to_sp_percentage
      t.integer :days_on_market
      t.integer :rooms
      t.integer :beds
      t.integer :baths
      t.date :closed
      t.references :report, index: true

      t.timestamps
    end
  end
end
