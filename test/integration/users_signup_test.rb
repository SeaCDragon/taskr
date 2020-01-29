require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
		ActionMailer::Base.deliveries.clear
	end

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

	test "valid user correct response with account activation" do
		get signup_path
		assert_difference 'User.count', 1 do
			post signup_path, params:{ user:{name: "atleast6", email:"test@user.com", password: "foobarbaz", password_confirmation: "foobarbaz"}}
		end
		assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
		testv_log_in(user)
		assert_not testv_logged_in?
		#invalid token
		get edit_account_activation_path("invalid token", email: user.email)
		assert_not testv_logged_in?
		#valid token, bad email
		get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not testv_logged_in?
		#success
		get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
		follow_redirect!
		assert_template "users/show"
		assert testv_logged_in?
	end
end
