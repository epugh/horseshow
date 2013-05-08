require File.dirname(__FILE__) + '/../test_helper'

class EventTest < Test::Unit::TestCase
  fixtures :events, :horses, :riders

  # Replace this with your real tests.
  def test_truth
    april = riders(:rider_1)
    assert_equal "April Jones", april.name
    trigger = horses(:horse_1)
    assert_equal "Trigger", trigger.name
    event2 = events(:event_2)
    assert_equal "5 Horse Scramble", event2.name
    
  end

end
