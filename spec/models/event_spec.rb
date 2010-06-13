require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @attr = { :name => "value for name" }
  end

  it "should create a new instance given valid attributes" do
    @user.events.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @event = @user.events.create(@attr)
    end

    it "should have a user attribute" do
      @event.should respond_to(:user)
    end

    it "should have the right associated user" do
      @event.user_id.should == @user.id
      @event.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user id" do
      Event.new(@attr).should_not be_valid
    end

    it "should require nonblank name" do
      @user.events.build(:name => "  ").should_not be_valid
    end

    it "should reject long name" do
      @user.events.build(:name => "a" * 141).should_not be_valid
    end
  end


end

