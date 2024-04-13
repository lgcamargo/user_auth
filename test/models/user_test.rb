# test/models/user_test.rb
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(email: "test@example.com", password: "Password123!")
    assert user.valid?
  end

  test "invalid user without email" do
    user = User.new(password: "Password123!")
    refute user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "invalid user with duplicate email" do
    existing_user = users(:one)
    user = User.new(email: existing_user.email, password: "Password123!")
    refute user.valid?
    assert_includes user.errors[:email], "has already been taken"
  end

  test "invalid user with invalid email format" do
    user = User.new(email: "invalid_email", password: "Password123!")
    refute user.valid?
    assert_includes user.errors[:email], "is not valid"
  end

  test "invalid user with invalid password format" do
    user = User.new(email: "test@example.com", password: "invalid")
    refute user.valid?
    assert_includes user.errors[:password], "is not valid"
  end
end
