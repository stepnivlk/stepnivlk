require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  include ApplicationHelper

  def setup
    @user = users(:foobar)
  end

  test "profile display" do
    get login_path
    post login_path, session: { email: @user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'

    # Checks if there are user infos.
    assert_select 'title', full_title(@user.name)
    assert_select 'span.h3', @user.name
    assert_match @user.email, response.body
    assert_match @user.phone, response.body
    @user.simple_user_infos.each do |info|
      assert_match info.info, response.body
    end

    # Checks if there is exactly 1 edit link, when logged in,
    # and 0, when no one is logged.
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    get user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user), count: 0
  end
end
