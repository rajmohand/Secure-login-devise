class AddCityContact < ActiveRecord::Migration
  def change
    add_column :contacts, :city, :string
  end
end
