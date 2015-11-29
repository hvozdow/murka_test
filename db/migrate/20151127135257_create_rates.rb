class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.date :DT
      t.integer :ProductID
      t.float :Rate

      t.timestamps null: false
    end
  end
end
