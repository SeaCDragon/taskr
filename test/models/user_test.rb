require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "test user", email: "user@test.com", password: "whocares", password_confirmation: "whocares")
	end

  test "should be valid" do
		assert @user.valid?
	end

	test "should have name" do
		@user.name = "       "
		assert_not @user.valid?
	end

	test "should have email" do
		@user.email = "       "
		assert_not @user.valid?
	end

	test "name should be right length" do
		@user.name = "a"*61
		assert_not @user.valid?
		@user.name = "a"*5
		assert_not @user.valid?
	end

	test "email shouldn't be too long" do
		@user.email = "a" * 244 + "@example.com"
	end

	test "email should have valid format" do
		invalid = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
		invalid.each do |address|
			@user.email = address
			assert_not @user.valid? "#{address} should be invalid"
		end
	end

	test "users should have unique emails" do
		duplicate = @user.dup
		@user.save
		duplicate.email = @user.email.upcase
		assert_not duplicate.valid?
	end

	test "password should not be blank" do
		@user.password = @user.password_confirmation = "           "
		assert_not @user.valid?
	end

	test "password should not be too short" do
		@user.password = @user.password_confirmation = "a"*5
		assert_not @user.valid?
	end
end
