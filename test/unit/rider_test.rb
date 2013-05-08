require File.dirname(__FILE__) + '/../test_helper'

class RiderTest < Test::Unit::TestCase
  fixtures :riders, :owners

  # Test duplicates
  def test_duplicate_rider
    owner = owners(:owner_1)
    rider = Rider.new(:owner => owner, :number => 52)
    rider.save
    
    rider2 = Rider.new(:owner => owner, :number => 53)
    rider2.save
    
    rider2.number = rider.number
    rider2.save
    rider2.reload
    assert_equal 53,rider2.number
  end
end
