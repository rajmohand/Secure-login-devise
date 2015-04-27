class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :User_id
      t.string :name
      t.string :phoneno
      t.text :Address
      t.string :email

      t.timestamps null: false
    end
  end
end
