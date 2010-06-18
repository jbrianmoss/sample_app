require 'spec_helper'

describe Event do
  before(:each) do
    @user = Factory(:user)
    @valid_attributes = {
      :name => "value for name",
      :description => "value for description",
      :start_time => Time.now,
      :end_time => Time.now,
      :stop_sales => Time.now,
      :quantity => 1,
      :price => 9.99,
      :currency => "value for currency",
      :max_tix => 1
    }
  end

  it "should create a new instance given valid attributes" do
    @user.events.create!(@valid_attributes)
  end

  describe "user associations" do

    before(:each) do
      @event = @user.events.create(@valid_attributes)
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
      Event.new(@valid_attributes).should_not be_valid
    end
	
    it "should require nonblank name" do
      @user.events.build(@valid_attributes.merge(:name => "  ")).should_not be_valid
    end

    it "should reject long name" do
      @user.events.build(@valid_attributes.merge(:name => "a" * 41)).should_not be_valid
    end

    it "should require nonblank description" do
      @user.events.build(@valid_attributes.merge(:description => "  ")).should_not be_valid
    end

    it "should reject long description" do
      @user.events.build(@valid_attributes.merge(:description => "a" * 301)).should_not be_valid
    end

  end


end
