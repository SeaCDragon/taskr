require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper

	def setup
		@user = users(:Charles)
	end

	test "profile display" do
		get user_path(@user)
		assert_template 'users/show'
		assert_select "title", full_title(@user.name)
		assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
		assert_match @user.projects.count.to_s, response.body
		assert_select 'div.pagination'
		@user.projects.paginate(page: 1).each do |project|
			assert_match project.title, response.body
		end
	end
end
