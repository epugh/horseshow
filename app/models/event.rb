class Event < ActiveRecord::Base
  has_many :event_participants
  
  
  validates_presence_of :name, :event_class, :fee
  validates_numericality_of :fee
  validates_uniqueness_of :event_class

  @scaffold_columns = [ 
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "event_class", :label => "Event Class Code"}),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "name", :label => "Class Title"}),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "description", :label => "Desc"}),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "sponsor"}),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "sponsor2" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "sponsor3" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "fee" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "cup" })
      
    ]
    
end
