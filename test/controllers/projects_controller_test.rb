require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def setup
  	@project = projects(:oldest)
  end

	test "should redirect create" do
		assert_no_difference 'Project.count' do
			post projects_path, params:{project:{title: "Test me"}}
		end
		assert_redirected_to login_url
	end

	test "should redirect destroy" do
		assert_no_difference 'Project.count' do
			delete project_path(@project)
		end
		assert_redirected_to login_url
	end

	test "shoud redirect destroy for wrong user" do
		testv_log_in users(:Charles)
		project = projects(:haterz_txt)
		assert_no_difference 'Project.count' do
			delete project_path(project)
		end
		assert_redirected_to root_url
	end
end
