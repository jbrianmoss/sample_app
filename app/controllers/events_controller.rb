class EventsController < ApplicationController
/
  before_filter :authenticate, :only => [:new, :index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:new, :index, :edit, :update, :destroy]
/ 
  def new
    @title = "Events"
    @event = user_from_remember_token.events.new
  end
  
  def create
    @user = user_from_remember_token
    @event = @user.events.build(params[:event])
    if @event.save
      flash[:success] = "Event added!"
      redirect_to
    else
      redirect_to root_path
    end
  end
  
  def index
    @title = "Events"
    @events = Event.paginate(:page => params[:page])
  end
  
  private

/
    def authenticate
      deny_access unless signed_in?
    end
    def correct_user
      @event = Event.find(params[:id])
      @user = @event.user;
      redirect_to(root_path) unless current_user?(@user)
    end
/
end
