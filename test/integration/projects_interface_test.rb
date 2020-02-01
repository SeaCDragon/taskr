require 'test_helper'

class ProjectsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:Charles)
  end

	test "project interface" do
		testv_log_in(@user)
		get root_path
    #assert_select 'div.pagination'
		# invalid submission
		assert_no_difference 'Project.count' do
			post projects_path, params:{project:{ title: "" }}
		end
		assert_select 'div#error_explanation'
		#valid submission
		title = "This project really ties the room together"
    assert_difference 'Project.count', 1 do
      post projects_path, params: { project: { title: title } }
    end
    assert_redirected_to @user
    follow_redirect!
    assert_match title, response.body
		#Delete
		assert_select 'a', text: 'delete'
    first_project = @user.projects.paginate(page: 1).first
    assert_difference 'Project.count', -1 do
      delete project_path(first_project)
    end
		get user_path(users(:Ellis))
    assert_select 'a', text: 'delete', count: 0
	end
end
