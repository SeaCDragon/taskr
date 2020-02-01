require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  def setup
  	@project = projects(:newer)
		@task = @project.tasks.build(content: "we dem bois")
  end

	test "validity" do
		assert @task.valid?
	end

	test "has project id" do
		@task.project_id = nil
		assert_not @task.valid?
	end

	test "invalid content" do
		@task.content = "  "
		assert_not @task.valid?
	end
end
