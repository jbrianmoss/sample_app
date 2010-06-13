require 'spec_helper'

describe EventsController do

  integrate_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @attr = { :name => "Lorem ipsum" }
      @event = Factory(:event, @attr.merge(:user => @user))

      @user.events.stub!(:build).and_return(@event)
    end

    describe "failure" do

      before(:each) do
        @event.should_receive(:save).and_return(false)
      end

      it "should render the home page" do
        post :create, :event => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @event.should_receive(:save).and_return(true)
      end

      it "should redirect to the home page" do
        post :create, :event => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :event => @attr
        flash[:success].should =~ /event created/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @event = Factory(:event, :user => @user)
      end

      it "should deny access" do
        @event.should_not_receive(:destroy)
        delete :destroy, :id => @event
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @event = Factory(:event, :user => @user)
        Event.should_receive(:find).with(@event).and_return(@event)
      end

      it "should destroy the micropost" do
        @event.should_receive(:destroy).and_return(@event)
        delete :destroy, :id => @event
      end
    end
  end


end
