require 'spec_helper'

feature "User login" do
  let(:user) { create(:user) }

  scenario "Log in correctly as a user" do
    visit_login_page
    expect_to_see_login_form
    enter_login_details
    submit_page
    expect_to_see_user_detail_page
  end

  scenario "Log in with a bad email/password combination" do
    visit_login_page
    expect_to_see_login_form
    enter_bad_login_details
    submit_page
    expect_to_see_login_form
    expect_to_see_invalid
  end

  def visit_login_page
    visit login_url
  end

  def expect_to_see_login_form
    expect(page).to have_content "Log In"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
    expect(page).to have_content "Remember"
  end

  def enter_login_details
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
  end

  def enter_bad_login_details
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password.reverse + "!"
  end

  def submit_page
    find_button("Log In").click
  end

  def expect_to_see_user_detail_page
    expect(page).to have_content user.name
    expect(page).to have_content "User Statistics"
  end

  def expect_to_see_invalid
    expect(page).to have_content "Invalid"
  end
end
