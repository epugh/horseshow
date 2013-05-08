class EventParticipant < ActiveRecord::Base
  belongs_to :event
  belongs_to :rider
  belongs_to :horse
  
  
  validates_presence_of :event
  validates_presence_of :rider
  validates_presence_of :horse
  
  #make sure our horse is in only one event at a time!
  def before_validation_on_create
    existingEventParticipant = EventParticipant.find(:first,:conditions=>"horse_id=#{self.horse.id} and event_id=#{self.event.id}")
    if !existingEventParticipant.nil?
      raise "You may not create a new event participant, this horse, #{existingEventParticipant.horse.name} is already part of this event with rider #{existingEventParticipant.rider.name}"
    end
  end 
  
  
  @scaffold_columns = [ 
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "event_class_code", :eval => "event_participant.event.event_class", :sort_sql => "event_id" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "event", :eval => "event_participant.event.name", :sort_sql => "event_id" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "rider", :eval => "event_participant.rider.name", :sort_sql => "rider_id" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "horse", :eval => "event_participant.horse.number", :sort_sql => "horse_id" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "result" })
    ]
    
    def owner
      self.rider.owner
    end
end
