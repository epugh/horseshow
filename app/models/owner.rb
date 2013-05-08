class Owner < ActiveRecord::Base
  has_many :riders, :dependent => :destroy
  has_many :horses, :dependent => :destroy
  belongs_to :payment_type
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_numericality_of :amount_paid
  
  
  @scaffold_columns = [ 
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "name" }),
      AjaxScaffold::ScaffoldColumn.new(self, { :name => "stable" })
    ]
    
    
    
  def total_fees
    total_fees = 0
    self.riders.each do |r|
      r.event_participants.each do |ep|
        # occasionally we get event participants that don't have an event!
        # shouldn't happen, maybe issue with datamodel?  If we had FK's, it would
        # never happen!
        if !ep.event.nil?
          total_fees = total_fees + ep.event.fee
        end
      end
    end
    total_fees
  
  end
  
  def amount_owed
    amount = total_fees - self.amount_paid
  
  end
  
  def paid_by_check?
    !payment_type.nil? && payment_type.id !=1
  end
  
  protected 
  def validate 
  if !paid_by_check?
    if !check_number.nil? && !check_number.empty?
      #errors.add(:check_number, "can only be supplied if you are paying by check") 
  
    end 
  end
  end 
  
end
