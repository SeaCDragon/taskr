require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:Charles)
	end

  test "unsuccessful edit" do
		testv_log_in(@user)
  	get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), params:{user:{name: "", email: "this@invalid", password: "foo", password_confirmation: "bar"}}
		assert_template 'users/edit'
		assert_select 'div.alert', 'The form contains 5 errors'
  end

	test "successful edit with friendly forwarding" do
		get edit_user_path(@user)
		testv_log_in(@user)
		assert_redirected_to edit_user_url(@user)
		assert_nil session[:forwarding_url]
		name = "Foo Bar"
		email = "foo@bar.com"
		patch user_path(@user), params: { user: {name: name, email: email, password: "", password_confirmation: ""}}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
end
