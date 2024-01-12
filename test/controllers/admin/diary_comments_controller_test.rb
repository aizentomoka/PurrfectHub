require "test_helper"

class Admin::DiaryCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_diary_comments_index_url
    assert_response :success
  end
end
