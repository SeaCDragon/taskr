require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
