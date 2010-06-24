require 'spec_helper'

describe EventsController do
  integrate_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_tag("title", /Events/)
    end
  end

end
