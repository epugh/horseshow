

class ReportingController < ApplicationController
  require "faster_csv"
  
  # nasty hacky attempt to do autocomplete.
  def set_ep_result
    ep = EventParticipant.find(params[:id])
    @successful = ep.update_attribute(:result, params[:value])
    ep.save!
    ep.reload
    render :text => ep.result
  end  
  
  # basic report of events, ordered by class
  def list_of_events
    @events = Event.find(:all)
    @report_name = "List of Events"
  end
  
  # basic report of owners, ordered by state, city, then by owner
  def list_of_owners
    @owners = Owner.find(:all, :order=>"state,city")
    @report_name = "List of Owners"
  end
  
  def list_of_owners_csv

    @owners = Owner.find(:all, :order=>"state,city")
    @report_name = "List of Owners"

    csv_string = FasterCSV.generate do |csv|
      csv << ["Name", "Stable", "Street 1", "Street 2", "City", "State", "Zip", "Phone", "Email"]

      @owners.each do |owner|
        
        csv << [owner.name,
              owner.stable,
              owner.street1,
              owner.street2,
              owner.city,
              owner.state,
              owner.zip,
              owner.phone,
              owner.email
              ]

      
      end
    end

    filename = "Horseshow_#{ENV['YEAR_OF_HORSESHOW']}_list_of_owners.csv"
    send_data(csv_string,
      :type => 'text/csv; charset=utf-8; header=present',
      :filename => filename)

  end  
  
  # basic report of owners, ordered by state, city, then by owner
  def list_of_placements
    @events = Event.find(:all)

    @report_name = "List of Placements"
  end
  
  # basic report of owners, ordered by state, city, then by owner
  def list_of_placements_csv
    @events = Event.find(:all)

    @report_name = "List of Placements"
    

    csv_string = FasterCSV.generate do |csv|
      csv << ["Class", "Class Name", "Result", "Horse", "Horse Number", "Rider", "Owner" ]

      @events.each do |event|
        eps = event.event_participants.reject{|ep| ep.result.blank?}
        eps.sort_by{ |ep| ep.result}.each do |ep|
          csv << [event.event_class,
                event.name,
                ep.result,
                ep.horse.name,
                ep.horse.number,
                ep.rider.name,
                ep.owner.name
                ]
                
        end
        eps = event.event_participants.select{|ep| ep.result.blank?}
        eps.each do |ep|
          csv << [event.event_class,
                event.name,
                ep.result,
                ep.horse.name,
                ep.horse.number,
                ep.rider.name,
                ep.owner.name
                ]
                
        end
      end
    end

    filename = "Horseshow_#{ENV['YEAR_OF_HORSESHOW']}_list_of_placements.csv"
    send_data(csv_string,
      :type => 'text/csv; charset=utf-8; header=present',
      :filename => filename)
      
  end  
  
  # List of all owners paying via "Open Check", plus how much should be written down.
  def open_checks_list
    @owners = Owner.find(:all, :conditions=> "payment_type_id =#{ENV['OPEN_CHECK_PAYMENT_TYPE']}", :order=>"name")
    @report_name = "List of Open Checks"
  end
  
  def all_payments_list
    
    @owners = Owner.find(:all, :order=>"payment_type_id,name")
    
  
    @report_name = "All Payments"
    
  end  
  
  # details for an announcer based on event
  def announcers_list

    @event = Event.find(params[:event][:id])
    
    @eps = EventParticipant.find(:all,:conditions=> "event_id =#{@event.id}", 
    :joins => "as ep inner join horses as h on ep.horse_id = h.id", 
    :order => "h.number asc")
    
  
    @report_name = "<center>Announcer's List<br/>Event Class: #{@event.event_class} &nbsp;&nbsp;#{@event.name}<p/>#{@event.description}<br/>Cup: #{@event.cup}</center>"
    render :layout=> false
  end
  
  # receipt for an owner based on what they have as event participants
  def registration_receipt

    # deal with both post and get methods of passing owner id.
    if params[:owner_id].nil?
      @owner = Owner.find(params[:owner][:id])
    else
      @owner = Owner.find(params[:owner_id])
    end
    # we do some funky logic to find all the riders in various events per owner.
    rider_ids =[]
    rider_ids = @owner.riders.collect do |rider|
      rider_ids << rider.id
#      rider_ids << ","
    end
#    p rider_ids
    rider_ids = rider_ids.join(",")  # get rid of trailing ,
    
    
    @eps = EventParticipant.find(:all, :conditions=> "rider_id in (#{rider_ids})",
    :joins => "as ep inner join riders as r on ep.rider_id = r.id inner join events as e on ep.event_id = e.id", 
    :order=>"e.event_class")
    
        @report_name = "Registration Receipt for #{@owner.name}"
    render :layout=>false
  end

  def report
  end

  def show
   @user = Event.find(params[:id])
  end

  private

 
end
