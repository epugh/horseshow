class CreateSchema < ActiveRecord::Migration
  def self.up
    # we'll use this a few times
    time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    
    create_table :owners do |t|
       t.column :name, :string
       t.column :street1, :string
       t.column :street2, :string
       t.column :city, :string
       t.column :state, :string
       t.column :zip, :string
       t.column :state, :string
       t.column :phone, :string
       t.column :email, :string
       t.column :amount_paid, :integer, :default=>0
       t.column :payment_type_id, :integer
       t.column :stable, :string
       t.column :check_number, :string
    
       t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
       t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end    
    
    create_table :payment_types do |t|
      t.column :name, :string
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end
    
    # create basic payments
    paymentTypes = ['Cash','Check','Open Check']
    paymentTypes.each do |pt|
      paymentType = PaymentType.new(:name => pt, :created_at => time, :updated_at => time)
      paymentType.save
    end
    
    create_table :horses do |t|
      t.column :owner_id, :int
      t.column :name, :string
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end

    create_table :riders do |t|
      t.column :name, :string
      t.column :owner_id, :integer
      t.column :number, :int
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end
    
    create_table :events do |t|
      t.column :name, :string
      t.column :event_class, :string
      t.column :sponsor, :string
      t.column :sponsor2, :string
      t.column :sponsor3, :string
      t.column :fee, :integer
      t.column :cup, :string
      t.column :created_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"
      t.column :updated_at, :datetime, :null => false, :default => "0000-00-00 00:00:00"     
    end
    

    
    create_table :event_participants do |t|
       t.column :event_id, :integer
       t.column :rider_id, :integer
       t.column :horse_id, :integer
       t.column "result", :string
       #t.column "created_at", :datetime, :null => false, :default => "0000-00-00 00:00:00"
       #t.column "updated_at", :datetime, :null => false, :default => "0000-00-00 00:00:00"
    end
    
    # move the number from horses over to riders
    add_column :horses, :number, :int
    remove_column :riders, :number    
    
  end

  def self.down
    # not set up to remove schema!
  end
end
