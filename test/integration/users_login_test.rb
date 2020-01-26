require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:Charles)
	end

  test "Invalid login correct response" do
		get login_path
		assert_select 'form[action="/login"]'
		assert_template "sessions/new"
		post login_path, params:{session:{email: "", password: ""}}
		assert_template "sessions/new"
		assert_not flash.empty?
		get root_path
		assert flash.empty?
	end

	test "valid login correct response" do
		#Phase 1: logging in
		get login_path
		post login_path, params:{session:{email: @user.email, password: 'password'}}
		assert testv_logged_in?
		assert_redirected_to @user
		follow_redirect!
		assert_select 'a[href=?]', login_path, count: 0
		assert_select 'a[href=?]', logout_path
		assert_select 'a[href=?]', user_path(@user)
		#Phase 2: logging out
		delete logout_path
		assert_not testv_logged_in?
		assert_redirected_to root_url
		#line 34 simulates a logout in another window/tab of the same browser
		delete logout_path
		follow_redirect!
		assert_select 'a[href=?]', login_path
		assert_select 'a[href=?]', logout_path, count: 0
		assert_select 'a[href=?]', user_path(@user), count: 0
	end

	test "login with remembering" do
		testv_log_in(@user, remember_me: '1')
		assert_equal cookies[:remember_token], assigns(:user).remember_token
	end

	test "login without remembering" do
		#login and remember first to create cookie
		testv_log_in(@user, remember_me: '1')
		#login and dont remember to insure cookies are deleted
		testv_log_in(@user, remember_me: '0')
		assert_empty cookies[:remember_token]
	end
end
