require 'spec_helper'

feature "User logout" do
  let(:user) { create(:user) }

  scenario "Log out when logged in" do
    log_in_as_user
    visit_home_page
    expect_to_see_account_links
    follow_logout_link
    expect_to_see_home_page
  end

  private

  def log_in_as_user
    visit_login_page
    enter_login_details
    submit_page
  end

  def visit_home_page
    visit root_url
  end

  def expect_to_see_account_links
    expect(page).to have_content user.name
    expect(page).to have_content "Settings"
    expect(page).to have_content "Log Out"
  end

  def follow_logout_link
    find_link("Log Out").click
  end

  def expect_to_see_home_page
    expect(page).to have_content "Rails Hangman"
    expect(page).to have_content "Welcome"
    expect(page).to have_content "Log In"
  end

  def visit_login_page
    visit login_url
  end

  def enter_login_details
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: user.password
  end

  def submit_page
    find_button("Log In").click
  end
end
