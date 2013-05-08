require File.dirname(__FILE__) + '/../test_helper'

class EventParticipantTest < Test::Unit::TestCase
  fixtures :events, :riders, :horses

  # Replace this with your real tests.
  def test_creating_event_participant
    event = events(:event_2)
    assert_equal 0,event.event_participants.size
    ep = EventParticipant.new
    ep.rider = riders(:rider_1)
    ep.event = event
    ep.horse = horses(:horse_1)
    assert_equal 0,ep.event.event_participants.size
    assert ep.save
    
    #assert_equal 1,ep.event.event_participants.size
    assert_equal '5 Horse Scramble', ep.event.name
    #puts "another test"
    #puts ep.rider.name
    ep2 = ep
    #puts "hello world"
    assert_not_nil ep2
    r = ep2.rider
    assert_not_nil r
    #puts r.name
    #puts "done"
    
    ep = EventParticipant.new
    ep.rider = riders(:rider_1)
    ep.event = event
    ep.horse = horses(:horse_2)
    
    assert_equal 0, ep.event.event_participants.size
    ep.event.event_participants << ep
    assert_equal 1, ep.event.event_participants.size
  
    # make sure two riders not on same horse in same test
    
    ep = EventParticipant.new
    ep.rider = riders(:rider_2)
    ep.event = event
    ep.horse = horses(:horse_2)
    assert_raise(RuntimeError) { ep.save } 
    
  end
end
