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

  it "allows you to create new goals for yourself" do
    fill_in "goal_name", :with => "lie less"
    click_on "Add Goal"
    guest_visit
    expect(page).to have_conten("lie less")
  end

  it "allows you to create private goals" do
    fill_in "goal_name", :with => "more private stuff"
    check('Private')
    click_on "Add Goal"
    expect(page).to have_content("more private stuff")
  end

  it "doesn't show private goals to other users" do
    fill_in "goal_name", :with => "more private stuff"
    check('Private')
    click_on "Add Goal"
    guest_visit
    expect(page).to_not have_content("more private stuff")
  end

  it "allows you to change goals from public to private" do
    click_on "Make Private"
    guest_visit
    expect(page).to_not have_content("my_goal")
  end

  it "allows you to change goals from private to public" do
    click_on "Make Public"
    guest_visit
    expect(page).to have_content("PRIVATESTUFF")
  end

  it "allows you to mark a goal as completed" do

  end

  def guest_visit
    user2 = FactoryGirl.build(:user)
    click_on "Sign Out Dawg"
    sign_in(user2)
    visit user_url(user)
  end

end