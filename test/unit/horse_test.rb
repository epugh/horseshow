require File.dirname(__FILE__) + '/../test_helper'

class HorseTest < Test::Unit::TestCase
 fixtures :horses
 
 def setup
   @trigger = Horse.find 1
 end

 def test_basics
   assert_kind_of Horse, horses(:horse_1)
   trigger = horses(:horse_1)
   assert_equal 'Trigger', trigger.name
   assert_equal @trigger, trigger
 end
end
