require 'fastercsv'
class ImportResultsController < ApplicationController
  def index
    
  end  
  def csv_import 
  #  @parsed_file=CSV::Reader.parse(params[:dump][:file])
    #FasterCSV.foreach( CSV_FILE_PATH, :headers           => true,
    #                                  :header_converters => :symbol,
    #                                  :converters        => :numeric ) do |line|    
    #n=0
    
    
    
    n = 0
    FasterCSV.parse( params[:dump][:file], :headers           => true,
                                      :header_converters => :symbol,
                                      :converters        => :numeric ).each do |line|
      n += 1
      puts "class: #{line[:class]}, horse: #{line[:horse]}, place: #{line[:place]}"
      event = Event.find_by_event_class(line[:class])
      horse = Horse.find_by_number(line[:horse])
      
      raise "Could not find event with class #{line[:class]} on row #{n + 1}" if event.nil?
      raise "Could not find horse with number #{line[:horse]} on row #{n + 1}" if horse.nil?

      ep = EventParticipant.find_by_event_id_and_horse_id(event.id, horse.id)
      raise "Could not find event participant for event class #{event.event_class} and horse #{horse.number} on row #{n + 1}" if ep.nil?
      
      ep.result = line[:place]
      ep.save!
      
    end
    flash[:info]="CSV Import Successful,  #{n} results added/updated to data base"
    redirect_to :controller => 'reporting'
  end
  
  def import_events
    FasterCSV.foreach('events.csv') do |line|
      puts line[0]
      if line[0].to_i < 36
        fee = 7
      else
        fee = 12
      end
      e = Event.new(:event_class => line[0], :name => line[1], :description => line[2], :fee => fee)
      e.save!
    end
    
  end
  

end