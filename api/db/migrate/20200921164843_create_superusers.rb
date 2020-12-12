class CreateSuperusers < ActiveRecord::Migration[5.1]
  def change
    create_table :superusers do |t|
      t.string :login, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
