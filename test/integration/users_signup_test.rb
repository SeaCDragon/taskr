require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid user correct response" do
		get signup_path
		assert_select 'form[action="/signup"]'
  	assert_no_difference 'User.count' do
  		post signup_path, params:{ user:{name: "", email: "this@invalid", password: "foo", password_confirmation: "bar"}}
  	end
		assert_template "users/new"
		assert_select 'div#error_explanation'
		assert_select 'div.field_with_errors'
  end

	test "valid user correct response" do
		get signup_path
		assert_difference 'User.count', 1 do
			post signup_path, params:{ user:{name: "atleast6", email:"test@user.com", password: "foobarbaz", password_confirmation: "foobarbaz"}}
		end
		follow_redirect!
		assert_template "users/show"
		assert is_logged_in?
		assert_not flash.empty?
	end
end
