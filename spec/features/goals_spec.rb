require 'spec_helper'

describe "CRUDing goals" do
  let(:user) {sign_up}
  let(:goal) {FactoryGirl.build(:goal, :user_id => user.id)}
  let(:pvt_goal) {FactoryGirl.build(:goal,
                                    :is_private => "true",
                                    :name => "PRIVATESTUFF",
                                    :user_id => user.id)}


  before(:each) do
    goal.save
    pvt_goal.save
    log_in(user)
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
    save_and_open_page
    expect(page).to have_content("lie less")
  end

  it "allows you to create private goals" do
    fill_in "goal_name", :with => "more private stuff"
    check('Private')
    click_on "Add Goal"
    # save_and_open_page
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

  # it "allows you to mark a goal as completed" do
#
#   end

end

def guest_visit
  user2 = FactoryGirl.build(:user)
  user2.save
  click_on "Sign Out Dawg"
  log_in(user2)
  visit user_url(user)
end