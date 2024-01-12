require "test_helper"

class Admin::RescuedCatCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rescued_cat_comments_index_url
    assert_response :success
  end
end
