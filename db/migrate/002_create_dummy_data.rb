class CreateDummyData < ActiveRecord::Migration
  def self.up
    # we'll use this a few times
    time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
=begin    
    eventcounter = 1
    while eventcounter < 82
      event = Event.new(:name => "Event #{eventcounter}", :fee => eventcounter, :event_class=>eventcounter)
      event.save!
      eventcounter +=1 
    end  
=end
    Event.create!(:event_class=>'1', :name=>'Beginner Riders - course A (fences not to exceed 18 inches).',:fee =>5)
    Event.create!(:event_class=>'2', :name=>'Beginner Riders - course B (fences not to exceed 18 inches).',:fee =>5)
    Event.create!(:event_class=>'3', :name=>'Hopeful Hunter over Fences - course A (fences not to exceed 2 feet 3 inches).',:fee =>5)
    Event.create!(:event_class=>'4', :name=>'Hopeful Hunter over Fences - course B (fences not to exceed 2 feet 3 inches).',:fee =>5)
    Event.create!(:event_class=>'5', :name=>'Open Hunter over Fences - course A (fences not to exceed 2 feet 6 inches).',:fee =>5)
    Event.create!(:event_class=>'6', :name=>'Open Hunter over Fences - course B (fences not to exceed 2 feet 6 inches).',:fee =>5)
    Event.create!(:event_class=>'7', :name=>'Tot Lead Line - Riders 6 and under, any type horse or pony led by an adult.',:fee =>5)
    Event.create!(:event_class=>'8', :name=>'Model Class (2 years and under) - Any breed horse or pony 2 years and under; to be judged on quality and conformation.',:fee =>5)
    Event.create!(:event_class=>'9', :name=>'Model Class (3 years and older) - Any breed horse or pony 3 years and older; to be judged on quality and conformation.',:fee =>5)
    Event.create!(:event_class=>'10', :name=>'Beginner Equitation (10 years and under) - walk and pleasure gait only; open to all breeds.',:fee =>5)
    Event.create!(:event_class=>'11', :name=>'Stock Seat Equitation (17 years and under) - walk, jog, lope; to be judged on hands, seat, & horsemanship.',:fee =>5)
    Event.create!(:event_class=>'12', :name=>'Hunt Seat Equitation (17 years and under) - walk, trot, canter; to be judged on hands, seat, & horsemanship.',:fee =>5)
    Event.create!(:event_class=>'13', :name=>'Saddle Seat Equitation (17 years and under) - walk, trot, canter; to be judged on hands, seat, & horsemanship.',:fee =>5)
    Event.create!(:event_class=>'14', :name=>'Go As You Please - walk and easy gait only; no canter.',:fee =>5)
    Event.create!(:event_class=>'15', :name=>'Go As You Please - walk and jog only; no lope.',:fee =>5)
    Event.create!(:event_class=>'16', :name=>'Go As You Please - walk and trot only; no canter.',:fee =>5)
    Event.create!(:event_class=>'17', :name=>'ASB Western Pleasure - walk, jog, and lope.',:fee =>5)
    Event.create!(:event_class=>'18', :name=>'Open Pleasure Pony (14.2 hands and under) - walk, trot, & canter.',:fee =>5)
    Event.create!(:event_class=>'19', :name=>'4H Lt. Horse & Pony - 4H members only; any type horse or pony; show at walk, pleasure gait, and canter.',:fee =>5)
    Event.create!(:event_class=>'20', :name=>'Beginner Rider Under Saddle - walk and trot only.',:fee =>5)
    Event.create!(:event_class=>'21', :name=>'Hopeful Hunter Under Saddle - walk, trot, and canter.',:fee =>5)
    Event.create!(:event_class=>'22', :name=>'Open Hunter Under Saddle - walk, trot, and canter.',:fee =>5)
    Event.create!(:event_class=>'23', :name=>'Juvenile All-Day Pleasure (17 years & under) - any horse or pony shown at walk and pleasure gait.',:fee =>5)
    Event.create!(:event_class=>'24', :name=>'Ranch Horse Pleasure Class - Junior (horses 5-years and under).',:fee =>5)
    Event.create!(:event_class=>'25', :name=>'Egg and Spoon Race.',:fee =>5)
    Event.create!(:event_class=>'26', :name=>'All-Day Pleasure - walk and easy gait',:fee =>5)
    Event.create!(:event_class=>'27', :name=>'All-Day Pleasure - walk and jog.',:fee =>5)
    Event.create!(:event_class=>'28', :name=>'All-Day Pleasure - walk and trot.',:fee =>5)
    Event.create!(:event_class=>'29', :name=>'Ladies Western Pleasure.',:fee =>5)
    Event.create!(:event_class=>'30', :name=>'Two-Gaited Plantation - shown at flat walk and running walk.',:fee =>5)
    Event.create!(:event_class=>'31', :name=>'Open Western Pleasure (horse or pony) - shown at walk, jog, and lope on a loose rein.',:fee =>5)
    Event.create!(:event_class=>'32', :name=>'Ladies Pleasure - walk and pleasure gait.',:fee =>5)
    Event.create!(:event_class=>'33', :name=>'Ranch Horse Pleasure Class - Senior (horses 6 years and older).',:fee =>5)
    Event.create!(:event_class=>'34', :name=>'Trail Racking - shown at trail pleasure walk and trail pleasure rack.',:fee =>5)
    Event.create!(:event_class=>'35', :name=>'Open Trail Class (any horse or pony) - obstacle course outside of ring with separate judge.',:fee =>5)
    
    Event.create!(:event_class=>'36', :name=>'Ranch Horse Trail Class - obstacle course outside of ring with separate judge.',:fee =>5)
    Event.create!(:event_class=>'37', :name=>'Ride-A-Buck - no shorts or chaps permitted.',:fee =>12)
    Event.create!(:event_class=>'38', :name=>'Costume Class.',:fee =>12)
    Event.create!(:event_class=>'39', :name=>'Hunter Pleasure Class - horse or pony; walk, trot, & canter; judged on manners and performance.',:fee =>12)
    Event.create!(:event_class=>'40', :name=>'Open Two-gaited Spotted Saddle Horse - walk and show gait.',:fee =>12)
    Event.create!(:event_class=>'41', :name=>'Precision Driving - cones.',:fee =>12)
    Event.create!(:event_class=>'42', :name=>'Ranch Horse Western Pleasure - Novice.',:fee =>12)
    Event.create!(:event_class=>'43', :name=>'ASB Country Pleasure - walk, trot, extended trot, and canter.',:fee =>12)
    Event.create!(:event_class=>'44', :name=>'Go As You Please - walk and easy gait only.',:fee =>12)
    Event.create!(:event_class=>'45', :name=>'Go As You Please - walk and jog only.',:fee =>12)
    Event.create!(:event_class=>'46', :name=>'Go As You Please - walk and trot only.',:fee =>12)
    Event.create!(:event_class=>'47', :name=>'ASB Pleasure - walk, trot, canter; judged on performance, quality, and manners.',:fee =>12)
    Event.create!(:event_class=>'48', :name=>'Ranch Horse Western Pleasure - open.',:fee =>12)
    Event.create!(:event_class=>'49', :name=>'Open Pleasure Driving - walk, trot, extended trot.',:fee =>12)
    Event.create!(:event_class=>'50', :name=>'Ladies Western Pleasure.',:fee =>12)
    Event.create!(:event_class=>'51', :name=>'Jack Benny Class - riders over age 39; walk and pleasure gait.',:fee =>12)
    Event.create!(:event_class=>'52', :name=>'Open Western Pleasure.',:fee =>12)
    Event.create!(:event_class=>'53', :name=>'Three-gaited Natural Mane and Tail - walk, trot, canter; judged on performance and quality.',:fee =>12)
    Event.create!(:event_class=>'54', :name=>'All-Day Pleasure - walk and easy gait only.',:fee =>12)
    Event.create!(:event_class=>'55', :name=>'Trail Racking - pleasure walk and pleasure rack.',:fee =>12)
    Event.create!(:event_class=>'56', :name=>'Open Five-gaited - walk, trot, slow-gait, rack, and canter; judged on performance and quality.',:fee =>12)
    Event.create!(:event_class=>'57', :name=>'Open Racking Horse - walk, slow rack, and fast rack; judged on performance, manners, and way of going.',:fee =>12)  
    Event.create!(:event_class=>'58', :name=>'ASB Country Hunter - Walk, trot, and canter.',:fee =>12)

=begin    
    event1 = Event.find(:first)
    
    counter=1
    horsenumbercounter = 1
    while counter < 100 
      owner = Owner.new(:name => "Owner #{counter}", :payment_type_id => 1)
      owner.save!
      horsecounter =1
      while horsecounter < 5
        horsenumbercounter +=1
        horse = Horse.new(:name => "Horse #{counter}-#{horsecounter}",:number => 10000 - horsenumbercounter)
        owner.horses << horse
        horsecounter +=1
        horse.save! 
      end 
      
      ridercounter = 1
      while ridercounter < 5
        
        rider = Rider.new(:name => "Rider #{counter}-#{ridercounter}")
        owner.riders << rider
        ridercounter +=1 
        rider.save!
      end      
      owner.save!
      #puts "#{owner.id}, #{owner.riders.first.id}, #{owner.horses.first.id}"
      ep = EventParticipant.new(:event=> event1, :rider=> owner.riders.first, :horse=>owner.horses.first)
      ep.save!
      counter += 1 
    end
    
=end    
    
  end

  def self.down
    # not set up to remove dummy data!
  end
end
