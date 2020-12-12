class CreateSubcategories < ActiveRecord::Migration[5.1]
  def change
    create_table :subcategories do |t|
      t.belongs_to :category
      t.string :name, null: false
      t.timestamps
    end
  end
end
