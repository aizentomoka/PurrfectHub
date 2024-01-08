require "test_helper"

class Admin::RescuedCatsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_rescued_cats_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_rescued_cats_show_url
    assert_response :success
  end
end
