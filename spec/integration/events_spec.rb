require 'spec_helper'

describe "Events" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new event" do
        lambda do
          visit root_path
          fill_in :event_name, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_tag("div#errorExplanation")
        end.should_not change(Event, :count)
      end
    end

    describe "success" do

      it "should make a new event" do
        name = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :event_name, :with => name
          click_button
          response.should have_tag("span.name", name)
        end.should change(Event, :count).by(1)
      end
    end
  end

  describe "destruction" do

    it "should destroy a event" do
      # Create a event.
      visit root_path
      fill_in :event_name, :with => "lorem ipsum"
      click_button
      # Destroy it.
      lambda { click_link "delete" }.should change(Event, :count).by(-1)
    end
  end
end

