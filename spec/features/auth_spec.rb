require 'spec_helper'

describe "the signup process" do

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  describe "signing up a user" do

    it "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'username', :with => "useruseruser"
      fill_in 'password', :with => "password"
      click_on "Sign Up Dawg"
      expect(page).to have_content "useruseruser"
    end
  end
end

describe "logging in" do
  before(:each) do
    sign_up
    visit new_session_url
  end
  it "has a login page" do

    expect(page).to have_content "Log In"
    expect(page).to have_content "username"
    expect(page).to have_content "password"
  end

  it "shows username on the homepage after login" do
    fill_in 'username', :with => "useruseruser"
    fill_in 'password', :with => "password"
    click_on "Sign In Dawg"
    expect(page).to have_content "useruseruser"
  end
end

describe "logging out" do

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to_not have_content "Sign Out Dawg"
  end


  it "has a logout button" do
    log_in(sign_up)
    click_on "Sign Out Dawg"
  end


  it "doesn't show username on the homepage after logout" do
    log_in(sign_up)
    click_on "Sign Out Dawg"
    expect(page).to_not have_content "other_user"
  end

end
