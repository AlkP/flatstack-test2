class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:edit, :show, :update, :destroy]
  before_action :check_access!, only: [:show, :update, :edit, :destroy]
  
  def index
    @events = Event.current
    @events = @events.by_user(current_user) if params[:my] == 'true' 
    @events = @events.page(params[:page])
  end
  
  def new
    @event = Event.new
    @event.date = DateTime.now
  end
  
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path
    else
      flash[:danger] = set_error(@event)
      render 'new'
    end
  end
  
  def update
    event = @event.update(event_params)
    if event
      redirect_to events_path
    else
      render edit
    end
  end
  
  def destroy
    @event.destroy
    redirect_to events_path
  end
  
  private
  
  def event_params
    params.require(:event).permit(:name, :period, :date, :repeat)
  end
  
  def check_access!
    return true if ("#{current_user.id}" == "#{@event.user_id}" and [ 'edit', 'update', 'destroy' ].include?(action_name)) or [ 'show' ].include?(action_name)
    flash[:danger] = t('.access_error')
    redirect_to events_path 
  end
  
  def set_event
    @event = Event.find(params[:id])
  end
end
