class Horse < ActiveRecord::Base
  belongs_to :owner
  has_many :event_participants, :dependent => :destroy
  validates_presence_of :owner
  validates_presence_of :number, :name
  validates_uniqueness_of :number

  @scaffold_columns = [ 
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "name" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "number" }),        
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "owner", :eval => "horse.owner.name", :sort_sql => "horses.name" })
    ]  
end
