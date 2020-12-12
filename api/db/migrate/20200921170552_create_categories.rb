class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :icon_index, default: 0
      t.timestamps
    end
  end
end
