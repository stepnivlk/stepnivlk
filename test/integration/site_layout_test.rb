require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'home/index'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", stream_path
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", galleries_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", user_path(1), count: 1
    user = users(:foobar)
    log_in_as(user)
    get root_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user), count: 2
    assert_select "a[href=?]", edit_user_path(user)
  end
end
