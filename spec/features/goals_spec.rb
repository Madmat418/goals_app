require 'spec_helper'

describe "CRUDing goals" do
  before(:each) do
    let(:goal) {FactoryGirl.build(:goal)}
    goal.save
    let(:pvt_goal) {FactoryGirl.build(:goal,
                                      :is_private => "true",
                                      :name => "PRIVATESTUFF")}
    pvt_goal.save
    let(:user) {sign_up}
    login(user)
  end

  it "shows public goals" do
    expect(page).to have_content("my_goal")
  end

  it "shows private goals on own show page" do
    expect(page).to have_content("PRIVATESTUFF")
  end

  it "doesn't show private goals to other users" do
    user2 = FactoryGirl.build(:user)
    click_on "Sign Out Dawg"
    sign_in(user2)
    visit user_url(user)
    expect(page).to_not have_content("PRIVATESTUFF")
  end


end