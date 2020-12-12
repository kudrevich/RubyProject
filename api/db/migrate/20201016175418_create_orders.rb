class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.belongs_to :subcategory
      t.belongs_to :executor, foreign_key: {to_table: :users}, optional: true
      t.string :city, null: false
      t.string :description, default: ''
      t.decimal :price, precision: 10, scale: 2, default: 0
      t.date :date
      t.string :picture, default: ''
      t.timestamps
    end
  end
end
