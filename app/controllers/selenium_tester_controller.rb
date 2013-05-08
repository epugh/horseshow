class SeleniumTesterController < ApplicationController

  def owner_name_to_id
    @owner = Owner.find_by_name(params[:id])
    
    if @owner.nil? 
      raise "Couldn't find owner for name #{params[:id]}"
    end
    render( :text => "owner id: <input type=text name=owner_id id=owner_id value=\"#{@owner.id}\">")
  
  end
  
  def reset
    
    #overly rigid!  Should be parameter!
    @owner = Owner.find_by_name('JayDavis')
    
    if @owner.nil? 
      raise "Couldn't find owner JayDavis"
    end  
    
    @owner.riders.each do |r|
      r.event_participants.each do |ep|
        ep.destroy
      end
      r.destroy
    end
    @owner.horses.each do |h|
      h.destroy
    end

    @owner.destroy
    
    render( :text => "Owner #{@owner.name} destroyed!")
  end
  
end
