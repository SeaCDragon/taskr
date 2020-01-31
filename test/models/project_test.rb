require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
	def setup
		@user = users(:Charles)
    # This code is idiomatically wrong
    @project = @user.projects.build(title: "test title")
	end

	test "sould be valid" do
		assert @project.valid?
	end

	test "user id should be present" do
		@project.user_id = nil
		assert_not @project.valid?
	end

	test "title should be present" do
		@project.title = "         "
		assert_not @project.valid?
	end

	test "title canot be too long" do
		@project.title = "a"*101
		assert_not @project.valid?
	end

	test "projects should appear most recent first" do
		assert_equal projects(:most_recent), Project.first
	end
end
