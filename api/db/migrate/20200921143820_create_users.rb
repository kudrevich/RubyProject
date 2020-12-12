class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.float :rank, default: 0.00
      t.string :avatar
      t.string :phone_number, null: false
      t.string :password_digest, null: false
      t.string :description, default: ''
      t.belongs_to :subcategory, optional: true
      t.timestamps
    end
  end
end
