require 'test_helper'

class BasicPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
		assert_select "title", "Taskr"
  end

  test "should get about" do
    get about_path
    assert_response :success
		assert_select "title", "About | Taskr"
  end

  test "should get help" do
    get help_path
    assert_response :success
		assert_select "title", "Help | Taskr"
  end

end
