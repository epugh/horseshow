class EventParticipantsController < ApplicationController
  include AjaxScaffold::Controller
  
  after_filter :clear_flashes
  
#  in_place_edit_for :event_participant, :result
 

  
  def index
    redirect_to :action => 'list'
  end


  def return_to_main
    # If you have multiple scaffolds on the same view then you will want to change this to
    # to whatever controller/action shows all the views 
    # (ex: redirect_to :controller => 'AdminConsole', :action => 'index')
    redirect_to :action => 'list'
  end

  def list
    # clear out our owners, we want all of them!
    session[:owner] = nil    
  end
  
  # All posts to change scaffold level variables like sort values or page changes go through this action
  def component_update  
    if request.xhr?
      # If this is an AJAX request then we just want to delegate to the component to rerender itself
      component
    else
      # If this is from a client without javascript we want to update the session parameters and then delegate
      # back to whatever page is displaying the scaffold, which will then rerender all scaffolds with these update parameters
      update_params :default_scaffold_id => "event_participant", :default_sort => nil, :default_sort_direction => "asc"
      return_to_main
    end
  end

  def component
    update_params :default_scaffold_id => "event_participant", :default_sort => nil, :default_sort_direction => "asc"
     
    @sort_sql = EventParticipant.scaffold_columns_hash[current_sort(params)].sort_sql rescue nil
    @sort_by = @sort_sql.nil? ? "#{EventParticipant.table_name}.#{EventParticipant.primary_key} asc" : @sort_sql  + " " + current_sort_direction(params)
    @paginator, @event_participants = paginate(:event_participants, :order => @sort_by, :per_page => default_per_page)
    
    @event_participants = filter_by_owner(@event_participants)
    
    render :action => "component", :layout => false
  end

  def new
    @event_participant = EventParticipant.new
    @successful = true

    return render(:action => 'new.rjs') if request.xhr?

    # Javascript disabled fallback
    if @successful
      @options = { :action => "create" }
      render :partial => "new_edit", :layout => true
    else 
      return_to_main
    end
  end
  
  def create
    begin
      @event_participant = EventParticipant.new(params[:event_participant])
      @successful = @event_participant.save
    rescue
      flash[:error], @successful  = $!.to_s, false
    end
    
    return render(:action => 'create.rjs') if request.xhr?
    if @successful
      return_to_main
    else
      @options = { :scaffold_id => params[:scaffold_id], :action => "create" }
      render :partial => 'new_edit', :layout => true
    end
  end
  
  def create_multiple_events
    event_classes = params[:event_classes]
    puts "raw event_classes: #{event_classes}"
    event_classes = event_classes.split(",")
    puts "events split size: #{event_classes.size}"
    event_classes.uniq!
    puts "events uniqued: #{event_classes}"
    event_classes.each do |event_class|
      begin
        event = Event.find_by_event_class(event_class)
        puts "found event #{event.id} for #{event_class}"
        @event_participant = EventParticipant.new(params[:event_participant])
        @event_participant.event = event
        @successful = @event_participant.save
        puts "success: #{@successful}"
      rescue
        puts "got an error"
        flash[:error], @successful  = $!.to_s, false
        puts "what happeened: #{flash[:error]}"
        break
      end
    end
    redirect_to :controller => 'owners', :action => :manage
    
  end

  def edit
    begin
      @event_participant = EventParticipant.find(params[:id])
      @successful = !@event_participant.nil?
    rescue
      flash[:error], @successful  = $!.to_s, false
    end
    
    return render(:action => 'edit.rjs') if request.xhr?

    if @successful
      @options = { :scaffold_id => params[:scaffold_id], :action => "update", :id => params[:id] }
      render :partial => 'new_edit', :layout => true
    else
      return_to_main
    end    
  end

  def update
    begin
      @event_participant = EventParticipant.find(params[:id])
      #@successful = @event_participant.update_attributes(params[:event_participant])
      @successful = @event_participant.update_attribute(:result, params[:event_participant][:result])
    rescue
      flash[:error], @successful  = $!.to_s, false
    end
    
    return render(:action => 'update.rjs') if request.xhr?

    if @successful
      return_to_main
    else
      @options = { :action => "update" }
      render :partial => 'new_edit', :layout => true
    end
  end

  def destroy
    begin
      @successful = EventParticipant.find(params[:id]).destroy
    rescue
      flash[:error], @successful  = $!.to_s, false
    end
    
    return render(:action => 'destroy.rjs') if request.xhr?
    
    # Javascript disabled fallback
    return_to_main
  end
  
  def cancel
    @successful = true
    
    return render(:action => 'cancel.rjs') if request.xhr?
    
    return_to_main
  end
end
