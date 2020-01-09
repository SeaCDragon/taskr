require 'test_helper'

class BasicPagesControllerTest < ActionDispatch::IntegrationTest
	test "should get root" do
		get root_url
		assert_response :success
	end

  test "should get home" do
    get basic_pages_home_url
    assert_response :success
		assert_select "title", "Taskr"
  end

  test "should get about" do
    get basic_pages_about_url
    assert_response :success
		assert_select "title", "About | Taskr"
  end

  test "should get help" do
    get basic_pages_help_url
    assert_response :success
		assert_select "title", "Help | Taskr"
  end

end
