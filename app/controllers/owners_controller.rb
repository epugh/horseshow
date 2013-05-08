class OwnersController < ApplicationController
  include AjaxScaffold::Controller
  
  after_filter :clear_flashes
  
  # Select the owner we want to be working with.  Put it in our session.
  def select_owner
    @owner = Owner.find(params[:owner_id])
    session[:owner] = @owner
    redirect_to :controller => 'owners', :action => 'manage'
  
  end
  
  def load_multi_events_picker
    @owner = session[:owner]
    render :update do |page|
      page.replace_html 'multi_events_picker', :partial=> 'multi_events_picker'
      page.visual_effect :highlight, 'multi_events_picker'
    end
  end
  
  def manage
    @owner = session[:owner]
    @owner.reload
    
  end
  
  
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
      update_params :default_scaffold_id => "owner", :default_sort => nil, :default_sort_direction => "asc"
      return_to_main
    end
  end

  def component
    update_params :default_scaffold_id => "owner", :default_sort => nil, :default_sort_direction => "asc"
   
    
    @sort_sql = Owner.scaffold_columns_hash[current_sort(params)].sort_sql rescue nil
    @sort_by = @sort_sql.nil? ? "#{Owner.table_name}.#{Owner.primary_key} asc" : @sort_sql  + " " + current_sort_direction(params)
    @paginator, @owners = paginate(:owners, :order => @sort_by, :per_page => default_per_page)
    
    # if we have an :owner in our session then filter down to just that owner!
    if session[:owner]
      @owners = [session[:owner]]
    end

    
    render :action => "component", :layout => false
  end
  
  def horses
    @owner = Owner.find(params[:id])
    @successful = true
  
    return if request.xhr?

    # Javascript disabled fallback
    if @successful
      @options = { :action => "horses", :id => params[:id] }
      render :partial => "horses", :layout => true
    else 
      return_to_main
    end 
  end
  
  def close_horses
    horses    
  end
  def new
    @owner = Owner.new
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
      @owner = Owner.new(params[:owner])
      @successful = @owner.save
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

  def edit
    begin
      @owner = Owner.find(params[:id])
      @successful = !@owner.nil?
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
      @owner = Owner.find(params[:id])
      @successful = @owner.update_attributes(params[:owner])
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
      @successful = Owner.find(params[:id]).destroy
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
