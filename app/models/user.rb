class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validate :password_format
  validate :email_format
  
  private
  
  def password_format
    unless password_valid?(password)
      errors.add(:password, "is not valid")
    end
  end

  def email_format
    unless email_valid?(email)
      errors.add(:email, "is not valid")
    end
  end

  def password_valid?(password)
    has_uppercase = /[[:upper:]]/.match(password)
    has_lowercase = /[[:lower:]]/.match(password)
    has_digit = /\d/.match(password)
    has_special = /[[:punct:]]/.match(password)

    # Check if all conditions are met
    password.length > 8 && has_uppercase && has_lowercase && has_digit && has_special
  end

  def email_valid?(email)
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    !!(email =~ email_regex)
  end
end
