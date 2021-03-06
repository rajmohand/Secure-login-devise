require 'csv'

class Contact < ActiveRecord::Base
  validates :name ,presence: true
  #  validates_format_of :name, :with => /\A[a-zA-Z]{3,15}$/i
  validates :email, presence: true , uniqueness: true
  validates :phoneno, presence: true,:numericality => {:only_integer => true}, format: { with: /\d{10}/, message: "bad format" }
  validates_format_of :email, :with => /\A([a-zA-Z][^@\s\W]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  def self.contactupload(filename,id)
    CSV.foreach("#{Rails.root}"+"/public/"+"#{filename}", headers: true) do |row|

      contact_hash = row.to_hash # exclude the price field
      contact = Contact.where(email: contact_hash["email"])

      if contact.count == 1
        contact.first.update_attributes(contact_hash)
      elsif
        contact_update = Contact.create!(contact_hash)
        contact_update.update_attributes(:User_id => id)
      else
        return contact.errors.full_messages
      end
    end
  end


  def self.bulk_insert(id)
    CSV.generate do |csv|
      csv << ['email','name','address','phoneno','city'] ## Header values of CSV
      all.each do |con|
        if con.User_id == id
          csv << [con.email, con.name, con.Address, con.phoneno, con.city] ##Row values of CSV
        end
      end
    end
  end

  # Name validations:
  # 1. It should always start with alphabets
  # 2. It should not contain any special charecters and numbers
  # 3. Name should be minimum 3 charecters maximum 15 charecters
  # Email:
  # 1. Email should be unique
  # 2. Email should not start with numbers and special charecters
end
