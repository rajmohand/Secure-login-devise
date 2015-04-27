class Contact < ActiveRecord::Base
  validates :name ,presance: true
  validates_format_of :name, :with => /\A[a-zA-Z]{3,15}$/
  validates :email, presence: true
  validates :phoneno, presence: true,:numericality => {:only_integer => true}, format: { with: /\d{10}/, message: "bad format" }
  validates_format_of :email, :with => /\A([a-zA-Z][^@\s\W]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/

  # Name validations:
  # 1. It should always start with alphabets
  # 2. It should not contain any special charecters and numbers
  # 3. Name should be minimum 3 charecters maximum 15 charecters
  # Email:
  # 1. Email should be unique
  # 2. Email should not start with numbers and special charecters
end
