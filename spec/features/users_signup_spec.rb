require 'spec_helper'

feature "User signup" do
  let(:user) { build(:user) }

  scenario "Registering with valid user details" do
    visit_signup_page
    expect_to_see_signup_form
    enter_user_details
    submit_page

    expect_to_see_user_detail_page
  end

  scenario "Registering with invalid user details (already taken)" do
    user.save!

    visit_signup_page
    expect_to_see_signup_form
    enter_user_details
    submit_page

    expect_to_see_signup_form
    expect_to_see_error
  end

  def visit_signup_page
    visit signup_url
  end

  def expect_to_see_signup_form
    expect(page).to have_content "Sign Up"
    expect(page).to have_content "User name"
    expect(page).to have_content "Email"
    expect(page).to have_content "Password"
  end

  def enter_user_details
    fill_in 'user_name', with: user.name
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
  end

  def submit_page
    find_button("Register").click
  end

  def expect_to_see_user_detail_page
    expect(page).to have_content user.name
    expect(page).to have_content "User Statistics"
  end

  def expect_to_see_error
    expect(page).to have_content "error"
  end
end
