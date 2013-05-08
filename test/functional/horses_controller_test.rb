require File.dirname(__FILE__) + '/../test_helper'
require 'horses_controller'

# Re-raise errors caught by the controller.
class HorsesController; def rescue_action(e) raise e end; end

class HorsesControllerTest < Test::Unit::TestCase
  fixtures :horses

  def setup
    @controller = HorsesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_something
    assert true
  end
  
  # A better generator might actually keep updated tests in here, until then its probably better to have nothing than something broken

end
