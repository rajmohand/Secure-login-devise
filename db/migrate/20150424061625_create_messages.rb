class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :reciver_id
      t.text :message
      t.string :senderemail
      t.string :reciveremail
      t.timestamps null: false
    end
  end
end
