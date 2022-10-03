require "test_helper"

class Public::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_tags_index_url
    assert_response :success
  end

  test "should get show" do
    get public_tags_show_url
    assert_response :success
  end

  test "should get destroy" do
    get public_tags_destroy_url
    assert_response :success
  end
end
