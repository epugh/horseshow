class PaymentType < ActiveRecord::Base
    has_many :owners
    
    def total_fees
      total_fees = 0
      
      self.owners.each do |o|
        total_fees = total_fees + o.total_fees
      end
      total_fees

    end
    
    def total_amount_paid
      total_amount_paid = 0
      
      self.owners.each do |o|
        total_amount_paid = total_amount_paid + o.amount_paid
      end
      total_amount_paid
    end
    
    def total_amount_owed
      total_amount_owed = 0
      
      self.owners.each do |o|
        total_amount_owed = total_amount_owed + o.amount_owed
      end
      total_amount_owed
    end
end
