require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user1 = users(:Charles)
		@user2 = users(:Ellis)
	end

  test "should get new" do
    get signup_path
    assert_response :success
  end

	test "should redirect edit when logged out" do
		get edit_user_path(@user1)
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should redirect update when logged out" do
		patch user_path(@user1), params:{user:{name: @user1.name, email: @user1.email}}
		assert_not flash.empty?
		assert_redirected_to login_url
	end

	test "should prevent creating an admin from the web" do
		testv_log_in(@user2)
		assert_not @user2.admin?
		patch user_path(@user2), params:{user:{password: 'password', password_confirmation: 'password', admin: true}}
		assert_not @user2.reload.admin?
	end

	test "should redirect deletion to login when not logged in" do
		assert_no_difference 'User.count' do
			delete user_path(@user1)
		end
		assert_redirected_to login_url
	end

	test "should redirect deletion to root when user is not admin" do
		testv_log_in(@user2)
		assert_no_difference 'User.count' do
			delete user_path(@user1)
		end
		assert_redirected_to root_url
	end

	test "index is for admin eyes only" do
		testv_log_in(@user2)
		get users_path
		assert_redirected_to root_url
	end

	test "should redirect edit when logged in as wrong user" do
		testv_log_in(@user2)
		get edit_user_path(@user1)
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		testv_log_in(@user2)
		patch user_path(@user1), params:{user:{name: @user1.name, email: @user1.email}}
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect index when logged out" do
		get users_path
		assert_redirected_to login_url
	end
end
