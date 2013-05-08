require File.dirname(__FILE__) + '/../test_helper'

class OwnerTest < Test::Unit::TestCase
  fixtures :owners, :horses, :riders, :events, :payment_types

  def test_that_tests_are_working
    assert_kind_of Owner, owners(:owner_1)
     eric = owners(:owner_1)
     assert_equal 'Eric Pugh', eric.name
     
  end
  
  # Test duplicates
  def test_duplicate_owner
    owner = owners(:owner_1)
    owner2 = Owner.new(:name=>"bob")
    owner2.save
    
    owner2.name = owner.name
    owner2.save
    
    owner2.reload
    assert_equal "bob",owner2.name
  end  

  def test_if_owner_paid_with_check
    eric = owners(:owner_1)
    eric.payment_type = nil
    assert !eric.paid_by_check?
    
    eric.payment_type = payment_types(:cash)
    
    assert !eric.paid_by_check?
    
    eric.payment_type = payment_types(:check)
    assert eric.paid_by_check?
    
    eric.payment_type = payment_types(:open_check)
    assert eric.paid_by_check?
    
  end
  
  def test_adding_horse
    eric = owners(:owner_1)
    trigger = horses(:horse_1)
    c = eric.horses.size
    eric.horses << trigger
    assert_equal c+1, eric.horses.size
  end
  
  def test_calculating_money_owned
    puts 'test_calculating_money_owned'
    time = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    
    eric = owners(:owner_1)
    eric.payment_type = payment_types(:cash)
    eric.check_number='fake'
    assert_equal 0, eric.amount_paid
    eric.amount_paid = 25
    assert_equal 25, eric.amount_paid
    
    eric.save
    
    april = riders(:rider_1)
    event = events(:event_1)
    horse = horses(:horse_1)
    
    ep = EventParticipant.new(:rider => april,:event=>event,:horse=>horse)
    ep.save
    
    eric.reload
    
    assert_equal 2,eric.riders.size
    
    assert_equal 10, eric.amount_owed
    
    bobbi = riders(:rider_2)
    event = events(:event_2)
    horse = horses(:horse_1)
    
    ep = EventParticipant.new(:rider => bobbi,:event=>event,:horse=>horse)
    ep.save
    
    eric.reload
   # assert_equal 2,eric.riders.size
    
    assert_equal 15, eric.amount_owed    
    
    
  end
    
end
