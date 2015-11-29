class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :DT
      t.integer :ProductID
      t.float :Price
      t.integer :Quantity

      t.timestamps null: false
    end
  end
end
