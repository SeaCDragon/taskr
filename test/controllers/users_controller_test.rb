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
end
